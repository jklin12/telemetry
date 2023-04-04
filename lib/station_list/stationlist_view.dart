import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/core/authentication_manager.dart';
import 'package:telemetry/station_list/station_detail_view.dart';
import 'package:telemetry/station_list/stationlist_view_model.dart';

class StationListView extends StatefulWidget {
  const StationListView({Key? key}) : super(key: key);

  @override
  State<StationListView> createState() => _StationListViewState();
}

class _StationListViewState extends State<StationListView> {
  StationListViewModel viewModel = Get.put(StationListViewModel());
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
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color(0XFFf2e400),
              title: const Text("Station List"),
            ),
            body: Obx(() => viewModel.isDataLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      builScreen(),
                    ],
                  ))));
  }

  Widget builScreen() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.1,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.stationListResponseModel!.data!.length,
          itemBuilder: (context, index) {
            var i = viewModel.stationListResponseModel!.data![index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                    onTap: () => Get.to(
                        StatinDetailView(stationId: i.stationId.toString())),
                    title: Text(
                      i.stationName ?? '',
                      style: Constant.title,
                    ),
                    subtitle: Text(
                      i.stationEquipment ?? '',
                      style: Constant.subTitle,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios)),
              ),
            );
          }),
    );
  }
}
