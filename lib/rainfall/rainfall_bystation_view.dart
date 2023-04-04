import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/core/authentication_manager.dart';
import 'package:telemetry/rainfall/rainfall_bystation_view_model.dart';
import 'package:telemetry/simple_table.dart';
import 'package:telemetry/station_list/model/stationlist_response_model.dart';

class RainfallBystationView extends StatefulWidget {
  const RainfallBystationView({Key? key}) : super(key: key);

  final columns = 10;
  final rows = 20;

  @override
  State<RainfallBystationView> createState() => _RainfallBystationViewState();
}

class _RainfallBystationViewState extends State<RainfallBystationView> {
  RainfallBystationViewModel viewModel = Get.put(RainfallBystationViewModel());
  late final AuthenticationManager _authManager;
  TextEditingController selectedDate = TextEditingController(
      text: DateFormat("yyyy-MM-dd").format(DateTime.now()).toString());
  Datum? selectedStation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authManager = Get.find();
    viewModel.getDailyRainfall(
        selectedDate.text, "2", _authManager.getToken()!);
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

    for (var element in viewModel.model!.data!.rainfall!) {
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
            child: data.isNotEmpty
                ? SimpleTablePage(
                    data: data, titleColumn: column, titleRow: row)
                : Center(
                    child: Text(
                      " Maaf! Data tidak ditemua.",
                      style: Constant.subTitle,
                    ),
                  )),
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
