import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemetry/rainfall/curent_rainfall_view.dart';
import 'package:telemetry/rainfall/daily_rainfall_view.dart';
import 'package:telemetry/rainfall/rainfall_bystation_view.dart';

class RainfallMenu extends StatefulWidget {
  const RainfallMenu({Key? key}) : super(key: key);

  @override
  State<RainfallMenu> createState() => _RainfallMenuState();
}

class _RainfallMenuState extends State<RainfallMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0XFFf2e400),
          title: const Text("Rainfall"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: const Text("Curent Rainfall"),
                    onTap: () => Get.to(const CurentRainfallView()),
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
                    title: const Text("Rainfall By Station"),
                    onTap: () => Get.to(const RainfallBystationView()),
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
                    title: const Text("Daily Rainfall Report"),
                    onTap: () => Get.to(const DailyRainfallView()),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  )),
            )
          ],
        ));
  }
}
