import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class Constant {
  static String baseUrl = 'http://202.173.16.249:8080';
  static TextStyle title = GoogleFonts.lato(
      textStyle: const TextStyle(
          fontWeight: FontWeight.w500, fontSize: 18, color: Color(0XFF688d9e)));
  static TextStyle subTitle = GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 15, color: Color(0XFF0f0f68)));
  static TextStyle tableHeader = GoogleFonts.lato(
      textStyle: const TextStyle(
          fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white));
  static const String mapBoxAccessToken =
      'pk.eyJ1IjoiZmFyaXNhaXp5IiwiYSI6ImNrd29tdWF3aDA0ZDAycXVzMWp0b2w4cWQifQ.tja8kdSB4_zpO5rOgGyYrQ';

  static const String mapBoxStyleId = 'clc7iss1x004s16pn1hlfkwgt';

  static final myLocation = LatLng(-7.6269335, 110.4025134);
}
