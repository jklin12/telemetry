import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/core/authentication_manager.dart';
import 'package:telemetry/rainfall/daily_rainfall_view_model.dart';
import 'package:telemetry/simple_table.dart';

class DailyRainfallView extends StatefulWidget {
  const DailyRainfallView({Key? key}) : super(key: key);

  @override
  State<DailyRainfallView> createState() => _DailyRainfallViewState();
}

class _DailyRainfallViewState extends State<DailyRainfallView> {
  DailyRainfallViewModel viewModel = Get.put(DailyRainfallViewModel());
  late final AuthenticationManager _authManager;
  TextEditingController selectedDate = TextEditingController(
      text: DateFormat("yyyy-MM-dd").format(DateTime.now()).toString());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authManager = Get.find();
    viewModel.getDailyRainfall(selectedDate.text, _authManager.getToken()!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: const Color(0XFFf2e400),
                title: Obx(() => viewModel.isDataLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Text(viewModel.dailyRainfallModel!.title ?? '')),
                bottom: const TabBar(
                  labelColor: Color(0XFF0f0f68),
                  indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(width: 5.0, color: Color(0XFF0f0f68)),
                      insets: EdgeInsets.symmetric(horizontal: 10.0)),
                  tabs: [
                    Tab(
                      text: "Rh(mm/h)",
                    ),
                    Tab(
                      text: "Rc(mm)",
                    ),
                  ],
                ),
              ),
              body: Obx(() => viewModel.isDataLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : builScreen()),
            )));
  }

  Widget builScreen() {
    List<String> column = [];
    for (var element in viewModel.dailyRainfallModel!.station!) {
      column.add(element.stationName.toString());
    }

    List<String> row = [];
    List<List<String>> data = [];
    List<List<String>> data2 = [];

    for (var element in viewModel.dailyRainfallModel!.rainfall!) {
      final List<String> rows = [];
      final List<String> rows2 = [];
      row.add(element.dateTime.toString());
      for (var elements in element.datas!) {
        rows.add(elements.rainFall1Hour.toString());
        rows2.add(elements.rainFallContinuous.toString());
      }
      data.add(rows);
      data2.add(rows2);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 50,
            child: TextField(
              controller: selectedDate,
              readOnly: true,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.parse(selectedDate.text),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2025),
                ).then((value) {
                  selectedDate.text =
                      DateFormat("yyyy-MM-dd").format(value!).toString();
                  viewModel.getDailyRainfall(
                      selectedDate.text, _authManager.getToken()!);
                });
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  suffixIcon: const Icon(Icons.calendar_month)),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.5,
          child: TabBarView(
            children: [
              data.isNotEmpty
                  ? SimpleTablePage(
                      data: data, titleColumn: row, titleRow: column)
                  : Center(
                      child: Text(
                        " Maaf! Data tidak ditemua.",
                        style: Constant.subTitle,
                      ),
                    ),
              data2.isNotEmpty
                  ? SimpleTablePage(
                      data: data2, titleColumn: row, titleRow: column)
                  : Center(
                      child: Text(
                        " Maaf! Data tidak ditemua.",
                        style: Constant.subTitle,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
