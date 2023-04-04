import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/core/authentication_manager.dart';
import 'package:telemetry/rainfall/curent_rainfall_view_model.dart';
import 'package:telemetry/simple_table.dart';

class CurentRainfallView extends StatefulWidget {
  const CurentRainfallView({Key? key}) : super(key: key);

  final columns = 10;
  final rows = 20;

  @override
  State<CurentRainfallView> createState() => _CurentRainfallViewState();
}

class _CurentRainfallViewState extends State<CurentRainfallView> {
  late final AuthenticationManager _authManager;
  CurentRainfallViewModel viewModel = Get.put(CurentRainfallViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authManager = Get.find();
    viewModel.getDailyRainfall(_authManager.getToken()!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color(0XFFf2e400),
              title: const Text("Curent Rainfall"),
            ),
            body: Obx(() => viewModel.isDataLoading.value
                ? const Center(child: CircularProgressIndicator())
                : builScreen())));
  }

  Widget builScreen() {
    List<String> column = [];
    for (var element in viewModel.model!.data!.datas!) {
      column.add(element.station!);
    }

    List<String> row = [
      "10-min Rainfall",
      "30-min Rainfall",
      "Hourly Rainfall",
      "3-hr Rainfall",
      "6-hr Rainfall",
      "12-hr Rainfall",
      "24-hr Rainfall",
      "Continous Rainfall",
      "Effective Rainfall",
      "Effective Intensity",
      "Previous Working",
      "Working Rainfal",
      "Working Rainfall (half-life:24h)",
      "Remarks",
    ];
    List<List<String>> data = [];
    for (var element in viewModel.model!.data!.datas!) {
      final List<String> rows = [];
      rows.addAll([
        element.rainFall10Minut ?? '',
        element.rainFall30Minute ?? '',
        element.rainFall1Hour ?? '',
        element.rainFall3Hour ?? '',
        element.rainFall6Hour ?? '',
        element.rainFall12Hour ?? '',
        element.rainFall24Hour ?? '',
        element.rainFallContinuous ?? '',
        element.rainFallEffective ?? '',
        element.rainFallEffectiveIntensity ?? '',
        element.rainFallPrevWorking ?? '',
        element.rainFallWorking ?? '',
        element.rainFallWorking24 ?? '',
        element.rainFallRemarks ?? ''
      ]);
      data.add(rows);
    }
    //print(data);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Date : ${DateFormat("E, d MMM yyyy HH:mm").format(viewModel.model!.data!.date!)}",
            style: Constant.title,
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: SimpleTablePage(
                data: data, titleColumn: column, titleRow: row)),
      ],
    );
  }
}
