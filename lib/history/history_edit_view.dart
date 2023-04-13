import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/core/authentication_manager.dart';
import 'package:telemetry/history/history_form_controller.dart';
import 'package:telemetry/station_list/model/stationlist_response_model.dart';

class HistoryEditView extends StatefulWidget {
  const HistoryEditView(
      {Key? key, this.id, this.title, this.station, this.body})
      : super(key: key);
  final String? id;
  final String? station;
  final String? title;
  final String? body;
  @override
  State<HistoryEditView> createState() => _HistoryEditViewState();
}

class _HistoryEditViewState extends State<HistoryEditView> {
  HistoryFormController viewModel = Get.put(HistoryFormController());
  late final AuthenticationManager _authManager;
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController bodyController = TextEditingController(text: '');
  Datum? selectedStation;
  XFile? imageFile;
  String? _retrieveDataError;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title ?? '';
    bodyController.text = widget.body ?? '';
    _authManager = Get.find();
    viewModel.getStationList(_authManager.getToken()!).then((value) =>
        selectedStation = viewModel.stationListResponseModel.data!
            .where((element) =>
                element.stationId == int.parse(widget.station ?? '0'))
            .first);
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0XFFf2e400),
          title: const Text("Tambah Data Riwayat"),
        ),
        body: Obx(() => viewModel.isDataLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8.0,
                    ),
                    builScreen(),
                  ],
                ),
              )));
  }

  Widget builScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText('Station :'),
        selectStation(),
        labelText('Judul :'),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
          child: TextField(
            controller: titleController,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
        labelText('Isi :'),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
          child: TextField(
            controller: bodyController,
            maxLines: 10,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
        labelText('Foto :'),
        pickImages(),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
          child: FutureBuilder<void>(
            future: retrieveLostData(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Text(
                    'You have not yet picked an image.',
                    textAlign: TextAlign.center,
                  );
                case ConnectionState.done:
                  return _previewImages();
                case ConnectionState.active:
                  if (snapshot.hasError) {
                    return Text(
                      'Pick image/video error: ${snapshot.error}}',
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return const Text(
                      'You have not yet picked an image.',
                      textAlign: TextAlign.center,
                    );
                  }
              }
            },
          ),
        ),
        formButton()
      ],
    );
  }

  Widget formButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
      child: Center(
          child: Obx(() => viewModel.isStoreLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () {
                    viewModel.editHistory(
                        _authManager.getToken()!,
                        widget.id!,
                        imageFile?.path != null
                            ? FormData({
                                "_method": "PUT",
                                "station": selectedStation!.stationId,
                                "history_title": titleController.text,
                                "history_body": bodyController.text,
                                "file": MultipartFile(File(imageFile!.path),
                                    filename: imageFile!.name)
                              })
                            : FormData({
                                "_method": "PUT",
                                "station": selectedStation!.stationId,
                                "history_title": titleController.text,
                                "history_body": bodyController.text,
                              }));
                  },
                  child: const Text("Simpan")))),
    );
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (imageFile != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: Image.file(File(imageFile!.path)),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget pickImages() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
      child: Card(
        child: IconButton(
          icon: const Icon(Icons.camera_enhance),
          onPressed: () => showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.camera_enhance),
                      label: const Text('Foto Kamera'),
                      onPressed: () {
                        _pickImage(ImageSource.camera);
                        Get.back();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.sd_storage),
                      label: const Text('Foto Galeri'),
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                        Get.back();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget labelText(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
      child: Text(label, style: Constant.subTitle),
    );
  }

  Widget selectStation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
      child: DropdownSearch<Datum>(
          items: viewModel.stationListResponseModel.data!,
          selectedItem: selectedStation,
          itemAsString: (Datum i) => i.stationName!,
          onChanged: (Datum? i) {
            selectedStation = i;
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          )),
          popupProps: PopupPropsMultiSelection.menu(
              showSearchBox: true, itemBuilder: _dropdownBuilder)),
    );
  }

  Widget _dropdownBuilder(
    BuildContext context,
    Datum? item,
    bool isSelected,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item!.stationName!),
      ),
    );
  }

  _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
          source: source, maxHeight: 480, maxWidth: 640, imageQuality: 50);
      setState(() {
        imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  /// Get from Camera

}
