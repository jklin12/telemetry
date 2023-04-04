// To parse this JSON data, do
//
//     final stationListResponseModel = stationListResponseModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

StationListResponseModel stationListResponseModelFromJson(String str) =>
    StationListResponseModel.fromJson(json.decode(str));

String stationListResponseModelToJson(StationListResponseModel data) =>
    json.encode(data.toJson());

class StationListResponseModel {
  StationListResponseModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<Datum>? data;
  String? message;

  factory StationListResponseModel.fromJson(Map<String, dynamic> json) =>
      StationListResponseModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.stationId,
    this.stationName,
    this.stationLat,
    this.stationLong,
    this.stationRiver,
    this.stationEquipment,
    this.stationProdYear,
    this.stationInstalatonDate,
    this.stationAuthority,
    this.stationGuardsman,
    this.stationRegNumber,
  });

  int? stationId;
  String? stationName;
  double? stationLat;
  double? stationLong;
  String? stationRiver;
  String? stationEquipment;
  String? stationProdYear;
  Station? stationInstalatonDate;
  Station? stationAuthority;
  String? stationGuardsman;
  String? stationRegNumber;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        stationId: json["station_id"],
        stationName: json["station_name"],
        stationLat: json["station_lat"].toDouble(),
        stationLong: json["station_long"].toDouble(),
        stationRiver: json["station_river"],
        stationEquipment: json["station_equipment"],
        stationProdYear: json["station_prod_year"],
        stationInstalatonDate:
            stationValues.map[json["station_instalaton_date"]],
        stationAuthority: stationValues.map[json["station_authority"]],
        stationGuardsman: json["station_guardsman"],
        stationRegNumber: json["station_reg_number"],
      );

  Map<String, dynamic> toJson() => {
        "station_id": stationId,
        "station_name": stationName,
        "station_lat": stationLat,
        "station_long": stationLong,
        "station_river": stationRiver,
        "station_equipment": stationEquipment,
        "station_prod_year": stationProdYear,
        "station_instalaton_date": stationValues.reverse[stationInstalatonDate],
        "station_authority": stationValues.reverse[stationAuthority],
        "station_guardsman": stationGuardsman,
        "station_reg_number": stationRegNumber,
      };
}

enum Station { JAN_00, JUN_11 }

final stationValues =
    EnumValues({"Jan-00": Station.JAN_00, "Jun-11": Station.JUN_11});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
