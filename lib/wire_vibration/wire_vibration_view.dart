import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/core/authentication_manager.dart';
import 'package:telemetry/simple_table.dart';
import 'package:telemetry/wire_vibration/wire_vibration_view_model.dart';

class WireVibrationView extends StatefulWidget {
  const WireVibrationView({Key? key}) : super(key: key);

  @override
  State<WireVibrationView> createState() => _WireVibrationViewState();
}

class _WireVibrationViewState extends State<WireVibrationView> {
  late final AuthenticationManager _authManager;
  WireVibrationViewModel viewModel = Get.put(WireVibrationViewModel());
  TextEditingController selectedDate = TextEditingController(
      text: DateFormat("yyyy-MM-dd").format(DateTime.now()).toString());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authManager = Get.find();
    viewModel.getData(selectedDate.text, _authManager.getToken()!);
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
                : Text(viewModel.model!.data!.title!)),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Wire",
                ),
                Tab(
                  text: "Vibration",
                ),
              ],
            ),
          ),
          body: Obx(() => viewModel.isDataLoading.value
              ? const Center(child: CircularProgressIndicator())
              : builScreen())),
    ));
  }

  Widget builScreen() {
    List<String> column = [];
    for (var element in viewModel.model!.data!.datas!.station!) {
      column.add(element.stationName!);
    }

    List<String> row = [];
    List<List<String>> data = [];
    List<List<String>> data2 = [];

    for (var element in viewModel.model!.data!.datas!.datas!) {
      final List<String> rows = [];
      final List<String> rows2 = [];
      row.add(element.dateTime.toString());
      for (var elements in element.datas!) {
        rows.add(elements.wire.toString());
        rows2.add(elements.vibration.toString());
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
                  viewModel.getData(
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
