import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:telemetry/core/authentication_manager.dart';
import 'package:telemetry/rainfall/model/rainfall_bystation_model.dart';
import 'package:telemetry/rainfall/rainfall_bystation_view_model.dart';
import 'package:telemetry/station_list/model/stationlist_response_model.dart';

class ChartRainFallView extends StatefulWidget {
  const ChartRainFallView({Key? key}) : super(key: key);

  @override
  State<ChartRainFallView> createState() => _ChartRainFallViewState();
}

class _ChartRainFallViewState extends State<ChartRainFallView> {
  late final AuthenticationManager _authManager;
  RainfallBystationViewModel viewModel = Get.put(RainfallBystationViewModel());
  TextEditingController selectedDate = TextEditingController(
      text: DateFormat("yyyy-MM-dd").format(DateTime.now()).toString());
  Datum? selectedStation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authManager = Get.find();
    viewModel.getDailyRainfall(
        selectedDate.text, "1", _authManager.getToken()!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: const Color(0XFFf2e400),
                title: Obx(
                  () => viewModel.isDataLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : Text(viewModel.model!.data!.title!),
                )),
            body: Obx(() => viewModel.isDataLoading.value
                ? const Center(child: CircularProgressIndicator())
                : builScreen())));
  }

  Widget builScreen() {
    List<String> column = [];
    for (var element in viewModel.model!.data!.rainfall!) {
      column.add(element.rainFallTime.toString());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: DropdownSearch<Datum>(
                      items: viewModel.station!.data!,
                      selectedItem: selectedStation,
                      itemAsString: (Datum i) => i.stationName!,
                      onChanged: (Datum? i) {
                        selectedStation = i;
                        viewModel.getDailyRainfall(
                            selectedDate.text,
                            selectedStation!.stationId.toString(),
                            _authManager.getToken()!);
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      )),
                      popupProps: PopupPropsMultiSelection.menu(
                          showSearchBox: true, itemBuilder: _dropdownBuilder)),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
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
                            selectedDate.text,
                            selectedStation!.stationId.toString(),
                            _authManager.getToken()!);
                      });
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        suffixIcon: const Icon(Icons.calendar_month)),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.4,
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: ''),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<Rainfall, String>>[
                ColumnSeries<Rainfall, String>(
                    dataSource: viewModel.model!.data!.rainfall!,
                    xValueMapper: (Rainfall sales, _) => sales.rainFallTime,
                    yValueMapper: (Rainfall sales, _) =>
                        double.parse(sales.rainFallContinuous!),
                    name: 'Rc',
                    // Enable data label
                    dataLabelSettings:
                        const DataLabelSettings(isVisible: true)),
                ColumnSeries<Rainfall, String>(
                    dataSource: viewModel.model!.data!.rainfall!,
                    xValueMapper: (Rainfall sales, _) => sales.rainFallTime,
                    yValueMapper: (Rainfall sales, _) =>
                        double.parse(sales.rainFall1Hour!),
                    name: 'Rh',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true))
              ]),
        ),
      ],
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
}
