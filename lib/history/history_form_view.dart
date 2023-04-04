import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/core/authentication_manager.dart';
import 'package:telemetry/history/history_form_controller.dart';
import 'package:telemetry/station_list/model/stationlist_response_model.dart';

class HistoryFormView extends StatefulWidget {
  const HistoryFormView({Key? key}) : super(key: key);

  @override
  State<HistoryFormView> createState() => _HistoryFormViewState();
}

class _HistoryFormViewState extends State<HistoryFormView> {
  HistoryFormController viewModel = Get.put(HistoryFormController());
  late final AuthenticationManager _authManager;
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController bodyController = TextEditingController(text: '');
  Datum? selectedStation;
  Map<String, dynamic> selectedLocalStation = {};
  late List<Map<String, dynamic>> localStation = [];
  XFile? imageFile;
  String? _retrieveDataError;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authManager = Get.find();
    viewModel.getStationList(_authManager.getToken()!);
    if (viewModel.connectionType.value == 0) {
      viewModel.getLocalStation().then((value) async {
        setState(() {
          for (var element in value) {
            localStation.add({
              "stationId": element['stationId'],
              "station_name": element['station_name']
            });
          }
        });
      });
    }
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText('Station :'),
          viewModel.connectionType.value == 0
              ? selectStationLocal()
              : selectStation(),
          labelText('Judul :'),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
            child: TextFormField(
              controller: titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Judul Tidak Boleh Kosong';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
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
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
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
      ),
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
                    if (_formKey.currentState!.validate()) {
                      viewModel.storeHistory(
                          _authManager.getToken()!,
                          imageFile?.path != null
                              ? FormData({
                                  "station": selectedStation?.stationId ?? 1,
                                  "history_title": titleController.text,
                                  "history_body": bodyController.text,
                                  "file": viewModel.connectionType.value == 0
                                      ? imageFile!.path
                                      : MultipartFile(File(imageFile!.path),
                                          filename: imageFile!.name)
                                })
                              : FormData({
                                  "station": selectedStation?.stationId ?? 1,
                                  "history_title": titleController.text,
                                  "history_body": bodyController.text,
                                }));
                    }
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

  Widget selectStationLocal() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
      child: DropdownSearch<Map<String, dynamic>>(
        items: localStation,
        selectedItem: selectedLocalStation,
        itemAsString: (Map<String, dynamic> i) => i['station_name'] ?? '',
        validator: (Map<String, dynamic>? i) {
          if (i == null) {
            return 'Station tidak boleh kosong';
          }
          return null;
        },
        onChanged: (Map<String, dynamic>? i) {
          selectedLocalStation = i!;
        },
        dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        )),
      ),
    );
  }

  Widget selectStation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
      child: DropdownSearch<Datum>(
          items: viewModel.stationListResponseModel.data!,
          selectedItem: selectedStation,
          itemAsString: (Datum i) => i.stationName!,
          validator: (Datum? i) {
            if (i == null) {
              return 'Station tidak boleh kosong';
            }
            return null;
          },
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
