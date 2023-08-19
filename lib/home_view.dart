import 'package:flutter/material.dart';
import 'package:flutter_easy_permission/easy_permissions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telemetry/absensi/absensi_index_view.dart';
import 'package:telemetry/chart/chart_menu.dart';
import 'package:telemetry/core/authentication_manager.dart';
import 'package:telemetry/flow/flow_view.dart';
import 'package:telemetry/history/history_index_view.dart';
import 'package:telemetry/home/home_view_model.dart';
import 'package:telemetry/map.dart/map_view.dart';
import 'package:telemetry/rainfall/rainfall_menu.dart';
import 'package:telemetry/station_list/stationlist_view.dart';
import 'package:telemetry/water_level/water_level_view.dart';
import 'package:telemetry/wire_vibration/wire_vibration_view.dart';
//import 'package:flutter_easy_permission/easy_permissions.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final AuthenticationManager _authManager;
  HomeViewModel viewModel = Get.put(HomeViewModel());
  //late FlutterEasyPermission _easyPermission;
  //static const permissions = [Permissions.CAMERA];
  //static const permissionGroup = [PermissionGroup.Camera];
  static const permissions = [
    Permissions.ACCESS_FINE_LOCATION,
    Permissions.CAMERA
  ];
  static const permissionGroup = [
    PermissionGroup.Location,
    PermissionGroup.Camera
  ];

  @override
  void initState() {
    super.initState();
    _authManager = Get.find();
    viewModel.getData(_authManager);
    FlutterEasyPermission.request(
        perms: permissions, permsGroup: permissionGroup);
    /* _easyPermission = FlutterEasyPermission()
      ..addPermissionCallback(
        onGranted: (requestCode, perms, perm) {
          debugPrint("Android Authorized:$perms");
          debugPrint("iOS Authorized:$perm");
        },
        onDenied: (requestCode, perms, perm, isPermanent) {
          if (isPermanent) {
            FlutterEasyPermission.showAppSettingsDialog(title: "Camera");
          } else {
            debugPrint("Android Deny authorization:$perms");
            debugPrint("iOS Deny authorization:$perm");
          }
        },
      );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0XFFf2e400),
          leading: const Center(child: FaIcon(FontAwesomeIcons.mountain)),
          title: const Text('Mt. Merapi Telemetry System'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Log Out',
              onPressed: () {
                viewModel.deleteToken(_authManager);
                _authManager.logOut();
              },
            ),
          ],
        ),
        body: Obx(
          () => viewModel.isDataLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      color: Colors.white,
                      child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 20,
                        crossAxisCount: 3,
                        children: <Widget>[
                          menuCard("Map", FontAwesomeIcons.mapLocation,
                              () => Get.to(const MapVoew())),
                          menuCard("Station List", FontAwesomeIcons.mapPin,
                              () => Get.to(const StationListView())),
                          //menuCard("Rainfall", FontAwesomeIcons.cloudRain,
                            //  () => Get.to(const RainfallMenu())),
                          menuCard("Water Level", FontAwesomeIcons.water,
                              () => Get.to(const WaterLevelView())),
                          //menuCard("Wire Vibration", FontAwesomeIcons.signsPost,
                            //  () => Get.to(const WireVibrationView())),
                          //menuCard("Flow", FontAwesomeIcons.wifi,
                            //  () => Get.to(const FlowView())),
                          menuCard("Grafik", FontAwesomeIcons.chartPie,
                              () => Get.to(const ChartMenur())),
                          menuCard("Riwayat Perawatan", FontAwesomeIcons.gears,
                              () => Get.to(const HistoryIndexView())),
                          menuCard(
                              "Data Absensi",
                              FontAwesomeIcons.fileCircleCheck,
                              () => Get.to(const AbsenIndexView()))
                        ],
                      ),
                    ),
                  ],
                ),
        ));
  }

  InkWell menuCard(String title, IconData icon, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              //color: const Color(0XFF0f0f68),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FaIcon(
                    icon,
                    size: 40,
                    color: const Color(0XFF0f0f68),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(title,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color(0XFF0f0f68))))
        ],
      ),
    );
  }
}
