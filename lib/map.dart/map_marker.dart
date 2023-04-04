import 'package:latlong2/latlong.dart';

class MapMarker {
  final String? image;
  final String? title;
  final String? address;
  final String? equipment;
  final String? productYear;
  final String? guadrsman;
  final LatLng? location;
  final int? rating;

  MapMarker({
    required this.image,
    required this.title,
    required this.address,
    required this.location,
    required this.rating,
    required this.equipment,
    required this.productYear,
    required this.guadrsman,
  });
}
