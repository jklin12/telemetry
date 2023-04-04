import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:telemetry/absensi/absensi_index_controller.dart';
import 'package:telemetry/absensi/model/absensi_index_model.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/core/authentication_manager.dart';
import 'package:telemetry/widget/image_dialog.dart';

class AbsenIndexView extends StatefulWidget {
  const AbsenIndexView({Key? key}) : super(key: key);

  @override
  State<AbsenIndexView> createState() => _AbsenIndexViewState();
}

class _AbsenIndexViewState extends State<AbsenIndexView> {
  late final AuthenticationManager _authManager;
  AbsensiIndexController controller = Get.put(AbsensiIndexController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authManager = Get.find();
    controller.getData(_authManager.getToken()!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: const Color(0XFFf2e400),
                title: const Text("Data Absensi")),
            body: Obx(() => controller.isDataLoading.value
                ? const Center(child: CircularProgressIndicator())
                : builScreen())));
  }

  Widget builScreen() {
    return controller.model.data.isEmpty
        ? const Center(child: Text("Mohon maaf data tidak ditemukan"))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: controller.model.data.length,
            itemBuilder: (context, index) {
              var datas = controller.model.data[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: Text(
                      datas.absenTime,
                      style: Constant.title,
                    ),
                    subtitle: Text(
                      "Koordinat :${datas.latitude},${datas.longitude}",
                      style: Constant.subTitle,
                    ),
                    trailing: IconButton(
                        onPressed: () => Get.to(ImageDialog(
                              image: "${Constant.baseUrl}/${datas.absenFile}",
                            )),
                        icon: const FaIcon(
                          FontAwesomeIcons.magnifyingGlassPlus,
                          color: Color(0XFF0f0f68),
                        )),
                  ),
                ),
              );
            });
  }
}
