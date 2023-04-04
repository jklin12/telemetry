// To parse this JSON data, do
//
//     final waterLevelModel = waterLevelModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'package:meta/meta.dart';
import 'dart:convert';

WaterLevelModel waterLevelModelFromJson(String str) =>
    WaterLevelModel.fromJson(json.decode(str));

String waterLevelModelToJson(WaterLevelModel data) =>
    json.encode(data.toJson());

class WaterLevelModel {
  WaterLevelModel({
    @required this.success,
    @required this.data,
    @required this.message,
  });

  bool? success;
  WaterLevelModelData? data;
  String? message;

  factory WaterLevelModel.fromJson(Map<String, dynamic> json) =>
      WaterLevelModel(
        success: json["success"],
        data: WaterLevelModelData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
        "message": message,
      };
}

class WaterLevelModelData {
  WaterLevelModelData({
    @required this.title,
    @required this.subTitle,
    @required this.datas,
    @required this.summaryData,
    @required this.filterDate,
  });

  String? title;
  String? subTitle;
  Datas? datas;
  SummaryData? summaryData;
  DateTime? filterDate;

  factory WaterLevelModelData.fromJson(Map<String, dynamic> json) =>
      WaterLevelModelData(
        title: json["title"],
        subTitle: json["subTitle"],
        datas: Datas.fromJson(json["datas"]),
        summaryData: SummaryData.fromJson(json["summaryData"]),
        filterDate: DateTime.parse(json["filterDate"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "datas": datas!.toJson(),
        "summaryData": summaryData!.toJson(),
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
    @required this.waterLevelDate,
    @required this.waterLevelTime,
    @required this.waterLevelHight,
  });

  int? stationId;
  int? station;
  String? stationName;
  DateTime? waterLevelDate;
  String? waterLevelTime;
  String? waterLevelHight;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        stationId: json["station_id"],
        station: json["station"],
        stationName: json["station_name"],
        waterLevelDate: DateTime.parse(json["water_level_date"]),
        waterLevelTime: json["wt"],
        waterLevelHight: json["average_wh"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "station_id": stationId,
        "station": station,
        "station_name": stationNameValues.reverse[stationName],
        "water_level_date":
            "${waterLevelDate!.year.toString().padLeft(4, '0')}-${waterLevelDate!.month.toString().padLeft(2, '0')}-${waterLevelDate!.day.toString().padLeft(2, '0')}",
        "wt": waterLevelTime,
        "average_wh": waterLevelHightValues.reverse[waterLevelHight],
      };
}

enum StationName {
  MRANGGEN,
  KOPEN,
  JURANGJERO,
  GIMBAL,
  KALIURANG,
  PULOWATU,
  GEMER2,
  SALAMSARI,
  KAJANGKOSO
}

final stationNameValues = EnumValues({
  "Gemer2": StationName.GEMER2,
  "Gimbal": StationName.GIMBAL,
  "Jurangjero": StationName.JURANGJERO,
  "Kajangkoso": StationName.KAJANGKOSO,
  "Kaliurang": StationName.KALIURANG,
  "Kopen": StationName.KOPEN,
  "Mranggen": StationName.MRANGGEN,
  "Pulowatu": StationName.PULOWATU,
  "Salamsari": StationName.SALAMSARI
});

enum WaterLevelHight {
  EMPTY,
  THE_002,
  average_wh,
  THE_053,
  THE_001,
  THE_052,
  THE_050,
  THE_049,
  THE_046,
  THE_047,
  THE_041,
  THE_040
}

final waterLevelHightValues = EnumValues({
  "***": WaterLevelHight.EMPTY,
  "0.01": WaterLevelHight.THE_001,
  "0.02": WaterLevelHight.THE_002,
  "-0.40": WaterLevelHight.THE_040,
  "-0.41": WaterLevelHight.THE_041,
  "-0.46": WaterLevelHight.THE_046,
  "-0.47": WaterLevelHight.THE_047,
  "-0.49": WaterLevelHight.THE_049,
  "-0.50": WaterLevelHight.THE_050,
  "-0.52": WaterLevelHight.THE_052,
  "-0.53": WaterLevelHight.THE_053,
  "": WaterLevelHight.average_wh
});

class Station {
  Station({
    @required this.stationId,
    @required this.stationName,
  });

  int? stationId;
  String? stationName;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        stationId: json["station_id"],
        stationName: json["station_name"],
      );

  Map<String, dynamic> toJson() => {
        "station_id": stationId,
        "station_name": stationNameValues.reverse[stationName],
      };
}

class SummaryData {
  SummaryData({
    @required this.average,
    @required this.max,
  });

  List<dynamic>? average;
  List<dynamic>? max;

  factory SummaryData.fromJson(Map<String, dynamic> json) => SummaryData(
        average: List<dynamic>.from(json["average"].map((x) => x)),
        max: List<dynamic>.from(json["max"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "average": List<dynamic>.from(average!.map((x) => x)),
        "max": List<dynamic>.from(max!.map((x) => x)),
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
