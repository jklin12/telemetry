// To parse this JSON data, do
//
//     final wireVibrationModel = wireVibrationModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'package:meta/meta.dart';
import 'dart:convert';

WireVibrationModel wireVibrationModelFromJson(String str) =>
    WireVibrationModel.fromJson(json.decode(str));

String wireVibrationModelToJson(WireVibrationModel data) =>
    json.encode(data.toJson());

class WireVibrationModel {
  WireVibrationModel({
    @required this.success,
    @required this.data,
    @required this.message,
  });

  bool? success;
  WireVibrationModelData? data;
  String? message;

  factory WireVibrationModel.fromJson(Map<String, dynamic> json) =>
      WireVibrationModel(
        success: json["success"],
        data: WireVibrationModelData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
        "message": message,
      };
}

class WireVibrationModelData {
  WireVibrationModelData({
    @required this.title,
    @required this.subTitle,
    @required this.datas,
    @required this.filterDate,
  });

  String? title;
  String? subTitle;
  Datas? datas;
  DateTime? filterDate;

  factory WireVibrationModelData.fromJson(Map<String, dynamic> json) =>
      WireVibrationModelData(
        title: json["title"],
        subTitle: json["subTitle"],
        datas: Datas.fromJson(json["datas"]),
        filterDate: DateTime.parse(json["filterDate"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "datas": datas!.toJson(),
        "filterDate":
            "${filterDate!.year.toString().padLeft(4, '0')}-${filterDate!.month.toString().padLeft(2, '0')}-${filterDate!.day.toString().padLeft(2, '0')}",
      };
}

class Datas {
  Datas({
    @required this.station,
    @required this.datas,
  });

  List<Station>? station;
  List<DatasData>? datas;

  factory Datas.fromJson(Map<String, dynamic> json) => Datas(
        station:
            List<Station>.from(json["station"].map((x) => Station.fromJson(x))),
        datas: List<DatasData>.from(
            json["datas"].map((x) => DatasData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "station": List<dynamic>.from(station!.map((x) => x.toJson())),
        "datas": List<dynamic>.from(datas!.map((x) => x.toJson())),
      };
}

class DatasData {
  DatasData({
    @required this.dateTime,
    @required this.datas,
  });

  String? dateTime;
  List<DataData>? datas;

  factory DatasData.fromJson(Map<String, dynamic> json) => DatasData(
        dateTime: json["date_time"],
        datas:
            List<DataData>.from(json["datas"].map((x) => DataData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date_time": dateTime,
        "datas": List<dynamic>.from(datas!.map((x) => x.toJson())),
      };
}

class DataData {
  DataData({
    @required this.stationId,
    @required this.station,
    @required this.stationName,
    @required this.wireVibrationDate,
    @required this.wireVibrationTime,
    @required this.wire,
    @required this.vibration,
  });

  int? stationId;
  int? station;
  String? stationName;
  DateTime? wireVibrationDate;
  String? wireVibrationTime;
  String? wire;
  String? vibration;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        stationId: json["station_id"],
        station: json["station"],
        stationName: json["station_name"],
        wireVibrationDate: DateTime.parse(json["wire_vibration_date"]),
        wireVibrationTime: json["wvt"],
        wire: json["average_w"].toString(),
        vibration: json["average_v"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "station_id": stationId,
        "station": station,
        "station_name": stationNameValues.reverse[stationName],
        "wire_vibration_date":
            "${wireVibrationDate!.year.toString().padLeft(4, '0')}-${wireVibrationDate!.month.toString().padLeft(2, '0')}-${wireVibrationDate!.day.toString().padLeft(2, '0')}",
        "wvt": wireVibrationTime,
        "average_w": wire,
        "average_v": vibration,
      };
}

enum StationName { JURANGJERO, GIMBAL, KALIURANG, PULOWATU, GEMER1, TRONO }

final stationNameValues = EnumValues({
  "Gemer1": StationName.GEMER1,
  "Gimbal": StationName.GIMBAL,
  "Jurangjero": StationName.JURANGJERO,
  "Kaliurang": StationName.KALIURANG,
  "Pulowatu": StationName.PULOWATU,
  "Trono": StationName.TRONO
});

enum Vibration { EMPTY, VIBRATION }

final vibrationValues =
    EnumValues({"": Vibration.EMPTY, "***": Vibration.VIBRATION});

class Station {
  Station({
    @required this.stationName,
  });

  String? stationName;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        stationName: json["station_name"],
      );

  Map<String, dynamic> toJson() => {
        "station_name": stationNameValues.reverse[stationName],
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
