import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/core/authentication_manager.dart';
import 'package:telemetry/flow/flow_view_model.dart';
import 'package:telemetry/simple_table.dart';

class FlowView extends StatefulWidget {
  const FlowView({Key? key}) : super(key: key);

  @override
  State<FlowView> createState() => _FlowViewState();
}

class _FlowViewState extends State<FlowView> {
  late final AuthenticationManager _authManager;
  FlowViewModel viewModel = Get.put(FlowViewModel());
  TextEditingController selectedDate = TextEditingController(
      text: DateFormat("yyyy-MM-dd").format(DateTime.now()).toString());

  @override
  void initState() {
    super.initState();
    _authManager = Get.find();
    viewModel.getData(selectedDate.text, _authManager.getToken()!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color(0XFFf2e400),
              title: Obx(() => viewModel.isDataLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Text(viewModel.model!.data!.title!)),
            ),
            body: Obx(() => viewModel.isDataLoading.value
                ? const Center(child: CircularProgressIndicator())
                : builScreen())));
  }

  Widget builScreen() {
    List<String> column = [];
    for (var elements in viewModel.model!.data!.datas!.station!) {
      column.add(elements.stationName!);
    }

    List<String> row = [];
    List<List<String>> data = [];

    for (var element in viewModel.model!.data!.datas!.datas!) {
      final List<String> rows = [];
      row.add(element.dateTime.toString());
      for (var elements in element.datas!) {
        rows.add(elements.flow!);
      }
      data.add(rows);
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
          child: data.isNotEmpty
              ? SimpleTablePage(data: data, titleColumn: row, titleRow: column)
              : Center(
                  child: Text(
                    " Maaf! Data tidak ditemua.",
                    style: Constant.subTitle,
                  ),
                ),
        ),
      ],
    );
  }
}
