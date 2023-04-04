import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/core/authentication_manager.dart';
import 'package:telemetry/station_list/station_detail_controller.dart';
import 'package:telemetry/widget/image_dialog.dart';
import 'package:timelines/timelines.dart';

class StatinDetailView extends StatefulWidget {
  const StatinDetailView({Key? key, this.stationId}) : super(key: key);
  final String? stationId;
  @override
  State<StatinDetailView> createState() => _StatinDetailViewState();
}

class _StatinDetailViewState extends State<StatinDetailView> {
  StationDetailController viewModel = Get.put(StationDetailController());
  late final AuthenticationManager _authManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authManager = Get.find();
    viewModel.getStationList(_authManager.getToken()!, widget.stationId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0XFFf2e400),
          title: const Text("Station Detail"),
        ),
        body: Obx(() => viewModel.isDataLoading.value
            ? const Center(child: CircularProgressIndicator())
            : buildScreen()));
  }

  Widget buildScreen() {
    return ListView(
      children: [
        detailData(),
        const Padding(
          padding: EdgeInsets.fromLTRB(20.0, 0, 8.0, 5.0),
          child: Text("Assets",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color(0XFF0f0f68))),
        ),
        viewModel.model!.data.stationAsset.isNotEmpty
            ? assetData()
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Data asset belum tersedia.",
                    style: TextStyle(fontSize: 14, color: Colors.red.shade500),
                  ),
                ),
              ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20.0, 0, 8.0, 5.0),
          child: Text("Riwayat Perawatan",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color(0XFF0f0f68))),
        ),
        viewModel.model!.data.stationHistory.isNotEmpty
            ? historyData()
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Data riwayat perawatan belum tersedia.",
                    style: TextStyle(fontSize: 14, color: Colors.red.shade500),
                  ),
                ),
              ),
      ],
    );
  }

  Widget detailData() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Station : ',
                    style: Constant.subTitle,
                    children: <TextSpan>[
                      TextSpan(
                          text: viewModel.model!.data.station.stationName,
                          style: Constant.title),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Latitude : ',
                    style: Constant.subTitle,
                    children: <TextSpan>[
                      TextSpan(
                          text: viewModel.model!.data.station.stationLat
                              .toString(),
                          style: Constant.title),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Longitude : ',
                    style: Constant.subTitle,
                    children: <TextSpan>[
                      TextSpan(
                          text: viewModel.model!.data.station.stationLong
                              .toString(),
                          style: Constant.title),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                child: RichText(
                  text: TextSpan(
                    text: 'River : ',
                    style: Constant.subTitle,
                    children: <TextSpan>[
                      TextSpan(
                          text: viewModel.model!.data.station.stationRiver,
                          style: Constant.title),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Product Year : ',
                    style: Constant.subTitle,
                    children: <TextSpan>[
                      TextSpan(
                          text: viewModel.model!.data.station.stationProdYear,
                          style: Constant.title),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Authority : ',
                    style: Constant.subTitle,
                    children: <TextSpan>[
                      TextSpan(
                          text: viewModel.model!.data.station.stationAuthority
                              .toString(),
                          style: Constant.title),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Guarsmand : ',
                    style: Constant.subTitle,
                    children: <TextSpan>[
                      TextSpan(
                          text: viewModel.model!.data.station.stationGuardsman
                              .toString(),
                          style: Constant.title),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Register Number : ',
                    style: Constant.subTitle,
                    children: <TextSpan>[
                      TextSpan(
                          text: viewModel.model!.data.station.stationRegNumber
                              .toString(),
                          style: Constant.title),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Equipment : ',
                        style: Constant.subTitle,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      viewModel.model!.data.station.stationTypes.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var datas = viewModel
                                      .model!.data.station.stationTypes;
                                  return Text(
                                    "${index + 1}. ${datas[index].stationType}",
                                    style: Constant.title,
                                  );
                                },
                                itemCount: viewModel
                                    .model!.data.station.stationTypes.length,
                              ),
                            )
                          : Container(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget assetData() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.model!.data.stationAsset.length,
        itemBuilder: (context, index) {
          var datas = viewModel.model!.data.stationAsset;
          return Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textInfo("Nama Asset", datas[index].assetName),
                    textInfo("Brand", datas[index].assetBrand ?? ''),
                    textInfo("Tipe", datas[index].assetType ?? ''),
                    textInfo(
                        "Serial Number", datas[index].assetSerialNumber ?? ''),
                    textInfo(
                        "Spesifikasi", datas[index].assetSpesification ?? ''),
                    textInfo("Tahun Pengadaan", datas[index].assetYear ?? ''),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 80, 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Foto : ',
                            style: Constant.subTitle,
                          ),
                          datas[index].assetTumbnial!.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () => Get.to(ImageDialog(
                                      image:
                                          "${Constant.baseUrl}/${datas[index].assetImgae}",
                                    )),
                                    child: Image.network(
                                      "${Constant.baseUrl}/${datas[index].assetTumbnial}",
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              2.2,
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget textInfo(String title, String body) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
        child: RichText(
          text: TextSpan(
            text: '$title : ',
            style: Constant.subTitle,
            children: <TextSpan>[
              TextSpan(text: body, style: Constant.title),
            ],
          ),
        ));
  }

  Widget historyData() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 8.0, 5.0),
      child: Timeline.tileBuilder(
        shrinkWrap: true,
        theme: TimelineTheme.of(context).copyWith(
          nodePosition: 0,
        ),
        builder: TimelineTileBuilder.connected(
          contentsAlign: ContentsAlign.basic,
          connectorBuilder: (_, index, __) {
            return const SolidLineConnector();
          },
          indicatorBuilder: (_, index) {
            return const DotIndicator(
                size: 20,
                color: Color(0xff193fcc),
                child: Icon(
                  Icons.circle,
                  size: 10.0,
                  color: Colors.white,
                ));
          },
          contentsBuilder: (context, index) {
            var datas = viewModel.model!.data.stationHistory;
            return Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "${datas[index].createdBy} - ${datas[index].createdAt}",
                          style: Constant.subTitle,
                        ),
                        subtitle: Text(
                          datas[index].historyTitle,
                          style: Constant.title,
                        ),
                      ),
                      Text(
                        datas[index].historyBody,
                        style: Constant.title,
                      ),
                      datas[index].historyTumbnial.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => Get.to(ImageDialog(
                                  image:
                                      "${Constant.baseUrl}/${datas[index].historyImgae}",
                                )),
                                child: Image.network(
                                  "${Constant.baseUrl}/${datas[index].historyTumbnial}",
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                ),
                              ),
                            )
                          : Container()
                    ],
                  )),
            );
          },
          itemCount: viewModel.model!.data.stationHistory.length,
        ),
      ),
    );
  }
}
