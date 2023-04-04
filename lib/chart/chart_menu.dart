import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';
//import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:telemetry/chart/chart_hydrograph_view.dart';
import 'package:telemetry/chart/chart_hytrograph_view.dart';
//import 'package:telemetry/chart/chart_rainfall_view.dart';

class ChartMenur extends StatefulWidget {
  const ChartMenur({Key? key}) : super(key: key);

  @override
  State<ChartMenur> createState() => _ChartMenurState();
}

class _ChartMenurState extends State<ChartMenur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0XFFf2e400),
          title: const Text("Daftar Grafik"),
        ),
        body: Column(
          children: [
            /*   Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: const Text("JudgmentGraph"),
                    onTap: () => Get.to(const ChartRainFallView()),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  )),
            ),*/
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: const Text("Hydrograph"),
                    onTap: () => Get.to(const ChartHydrographView()),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: const Text("Hytrograph"),
                    onTap: () => Get.to(const ChartHytrographView()),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  )),
            ),
          ],
        ));
  }
}
