import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemetry/absensi/absensi_from_view.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/core/authentication_manager.dart';
import 'package:telemetry/history/history_form_view.dart';
import 'package:telemetry/history/history_edit_view.dart';
import 'package:telemetry/history/history_index_controller.dart';
import 'package:telemetry/widget/image_dialog.dart';

class HistoryIndexView extends StatefulWidget {
  const HistoryIndexView({Key? key}) : super(key: key);

  @override
  State<HistoryIndexView> createState() => _HistoryIndexViewState();
}

class _HistoryIndexViewState extends State<HistoryIndexView> {
  HistoryIndexController viewModel = Get.put(HistoryIndexController());
  late final AuthenticationManager _authManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authManager = Get.find();
    viewModel.getStationList(_authManager.getToken()!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0XFFf2e400),
          title: const Text("Riwayat Perawatan Station"),
        ),
        floatingActionButton: Obx(() => viewModel.isDataLoading.value
            ? Container()
            : viewModel.localModel.isEmpty
                ? Container()
                : FloatingActionButton.extended(
                    onPressed: () {},
                    label: Text(" ${viewModel.localModel.length} Menunggu"),
                    icon: const Icon(Icons.history))),
        body: ListView(
          children: [
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
              child: ElevatedButton.icon(
                onPressed: () => addButton(),
                icon: const Icon(Icons.add),
                label: const Text("Tambah Riwayat"),
                style: ElevatedButton.styleFrom(
                    primary: const Color(
                        0XFF0f0f68) //elevated btton background color
                    ),
              ),
            ),
            Obx(() => viewModel.isDataLoading.value
                ? const Center(child: CircularProgressIndicator())
                : buildScreen()),
          ],
        ));
  }

  addButton() async {
    viewModel.cekAbsen(_authManager.getToken()!).then((value) {
      if (value) {
        //Get.to(() => const HistoryFormView());
        navigateForm();
      } else {
        Get.defaultDialog(
            middleText: 'Silahkan Absen Terlebih Dahulu',
            textConfirm: 'Absensi',
            textCancel: "Batal",
            title: "Absensi",
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.off(() => const AbsensiFormView());
            });
      }
    });
  }

  navigateForm() async {
    var data = await Get.to(const HistoryFormView());

    if (data == 'success') {
      //viewModel.getStationList(_authManager.getToken()!);
    }
  }

  editButton(var datas) async {
    var data = await Get.to(HistoryEditView(
      id: datas.historyId.toString(),
      title: datas.historyTitle,
      body: datas.historyBody,
      station: datas.station,
    ));
    if (data == 'success') {
      viewModel.getStationList(_authManager.getToken()!);
    }
  }

  Widget buildScreen() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.2,
      child: viewModel.model.data.isEmpty
          ? const Center(child: Text("Mohon maaf data tidak ditemukan"))
          : ListView.builder(
              shrinkWrap: true,
              itemCount: viewModel.model.data.length,
              itemBuilder: (context, index) {
                var datas = viewModel.model.data;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ExpansionTile(
                      title: Text(datas[index].historyTitle,
                          style: Constant.title),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                          child: Text(
                              "Station : ${datas[index].stations.stationName}",
                              style: Constant.subTitle),
                        ),
                        /*Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                      child: Text("Asset : ${datas[index].asset!.assetName ?? ''}",
                          style: Constant.subTitle),
                    ),*/
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                          child: Text(datas[index].historyBody ?? '',
                              style: Constant.subTitle),
                        ),
                        textInfo("Dibuat Oleh ${datas[index].createdBy}",
                            " Pada ${datas[index].createdAt}"),
                        textInfo("Diupdate Oleh ${datas[index].updatedBy}",
                            " Pada ${datas[index].updatedAt}"),
                        datas[index].historyTumbnial != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () => Get.to(ImageDialog(
                                    image:
                                        "${Constant.baseUrl}/${datas[index].historyImgae}",
                                  )),
                                  child: Center(
                                    child: Image.network(
                                      "${Constant.baseUrl}/${datas[index].historyTumbnial}",
                                      fit: BoxFit.cover,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => editButton(datas[index]),
                                icon: const Icon(Icons.edit),
                                label: const Text("Edit"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .yellow //elevated btton background color
                                    ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: 'Hapus Data',
                                    content: Text(
                                        "Hapus riwayat ${datas[index].historyTitle} ?"),
                                    textConfirm: 'Ya',
                                    confirmTextColor: Colors.white,
                                    onConfirm: () {
                                      viewModel.deleteData(
                                          _authManager.getToken()!,
                                          datas[index].historyId.toString());
                                      viewModel.getStationList(
                                          _authManager.getToken()!);
                                      Get.back();
                                    },
                                    textCancel: 'Tidak',
                                  );
                                },
                                icon: const Icon(Icons.delete),
                                label: const Text("Hapus"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .red //elevated btton background color
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  Widget textInfo(String title, String body) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
        child: RichText(
          text: TextSpan(
            text: '$title - ',
            style: Constant.subTitle,
            children: <TextSpan>[
              TextSpan(text: body, style: Constant.title),
            ],
          ),
        ));
  }
}
