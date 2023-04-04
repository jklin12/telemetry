import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easy_permission/easy_permissions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:telemetry/absensi/absensi_index_controller.dart';
import 'package:telemetry/core/authentication_manager.dart';

class AbsensiFormView extends StatefulWidget {
  const AbsensiFormView({Key? key}) : super(key: key);

  @override
  State<AbsensiFormView> createState() => _AbsensiFormViewState();
}

class _AbsensiFormViewState extends State<AbsensiFormView> {
  String? retrieveDataError;
  String? currentAddress;
  String? formatted;
  bool isLocationLoading = true;
  XFile imageFile = XFile('');
  dynamic pickImageError;
  late Position currentPosition;

  final ImagePicker picker = ImagePicker();
  final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;

  AbsensiIndexController viewModel = Get.put(AbsensiIndexController());
  late final AuthenticationManager _authManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authManager = Get.find();

    geolocator.getCurrentPosition().then((Position position) {
      setState(() {
        currentPosition = position;
        isLocationLoading = false;
      });
      print(currentPosition);
    });
  }

  @override
  void dispose() {
    //_easyPermission.dispose();
    super.dispose();
  }

  getdate() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');
    final String formated = formatter.format(now);
    setState(() {
      formatted = formated;
      print(formatted);
    });
  }

  getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        currentAddress =
            "${place.subLocality},${place.locality}, ${place.country}";
      });
      print(currentAddress);
    } catch (e) {
      print(e);
    }
  }

  pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await picker.pickImage(
          source: source, maxHeight: 480, maxWidth: 640, imageQuality: 50);
      setState(() {
        imageFile = pickedFile!;
      });
    } catch (e) {
      setState(() {
        pickImageError = e;
      });
    }
  }

  Text? getRetrieveErrorWidget() {
    if (retrieveDataError != null) {
      final Text result = Text(retrieveDataError!);
      retrieveDataError = null;
      return result;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0XFFf2e400),
          title: const Text("Absensi")),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 1.3,
            child: _previewImages(),
          ),
          isLocationLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Obx(
                  () => viewModel.isDataLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : imageFile.path.isEmpty
                          ? Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                              child: ElevatedButton.icon(
                                onPressed: () => pickImage(ImageSource.camera),
                                icon: const Icon(FontAwesomeIcons.camera),
                                label: const Text("Ambil Foto"),
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(
                                        0XFF0f0f68) //elevated btton background color
                                    ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                              child: ElevatedButton.icon(
                                onPressed: () => viewModel.storeData(
                                    _authManager.getToken()!,
                                    FormData({
                                      "user_id": '1',
                                      "latitude": currentPosition.latitude,
                                      "longitude": currentPosition.longitude,
                                      "absen_file": MultipartFile(
                                          File(imageFile.path),
                                          filename: imageFile.name)
                                    })),
                                icon: const Icon(FontAwesomeIcons.check),
                                label: const Text("Simpan"),
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(
                                        0XFF0f0f68) //elevated btton background color
                                    ),
                              ),
                            ),
                )
        ],
      ),
    );
  }

  Widget _previewImages() {
    final Text? retrieveError = getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (imageFile.path.isNotEmpty) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: Image.file(File(imageFile.path)),
      );
    } else if (pickImageError != null) {
      return Center(
        child: Text(
          'Pick image error: $pickImageError',
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return const Center(
        child: Text(
          'Mohon ambil foto',
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
