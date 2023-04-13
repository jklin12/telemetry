import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/core/authentication_manager.dart';

import 'package:telemetry/station_list/stationlist_view_model.dart';
import 'package:latlong2/latlong.dart';

class MapVoew extends StatefulWidget {
  const MapVoew({Key? key}) : super(key: key);

  @override
  State<MapVoew> createState() => _MapVoewState();
}

class _MapVoewState extends State<MapVoew> with TickerProviderStateMixin {
  StationListViewModel viewModel = Get.put(StationListViewModel());
  late final AuthenticationManager _authManager;
  final pageController = PageController();
  int selectedIndex = 0;
  var currentLocation = Constant.myLocation;

  late final MapController mapController;
  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _authManager = Get.find();
    viewModel.getStationList(_authManager.getToken()!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0XFFf2e400),
            title: const Text("MAP")),
        body: Obx(
          () => viewModel.isDataLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        minZoom: 5,
                        maxZoom: 18,
                        zoom: 10,
                        center: Constant.myLocation,
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              "https://api.mapbox.com/styles/v1/farisaizy/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                          additionalOptions: {
                            'accessToken': Constant.mapBoxAccessToken,
                            'mapStyleId': Constant.mapBoxStyleId,
                          },
                        ),
                        MarkerLayerOptions(
                          markers: [
                            for (int i = 0; i < viewModel.mapMarker.length; i++)
                              Marker(
                                height: 40,
                                width: 40,
                                point: viewModel.mapMarker[i].location ??
                                    Constant.myLocation,
                                builder: (_) {
                                  return GestureDetector(
                                    onTap: () {
                                      pageController.animateToPage(
                                        i,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                      selectedIndex = i;
                                      currentLocation =
                                          viewModel.mapMarker[i].location ??
                                              Constant.myLocation;
                                      _animatedMapMove(currentLocation, 11.5);
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/map_marker.svg',
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 2,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: PageView.builder(
                        controller: pageController,
                        onPageChanged: (value) {},
                        itemCount: viewModel.mapMarker.length,
                        itemBuilder: (_, index) {
                          final item = viewModel.mapMarker[index];
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: const Color.fromARGB(255, 30, 29, 29),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.title ?? '',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Riveer : ${item.address} ",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Equipment : ${item.equipment} ",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Product Year : ${item.productYear} ",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Coordinates : ${item.location!.latitude.toString()}, ${item.location!.longitude.toString()}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Guardman : ${item.guadrsman} ",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
        ));
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }
}
