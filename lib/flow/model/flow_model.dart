// To parse this JSON data, do
//
//     final flowModel = flowModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'package:meta/meta.dart';
import 'dart:convert';

FlowModel flowModelFromJson(String str) => FlowModel.fromJson(json.decode(str));

String flowModelToJson(FlowModel data) => json.encode(data.toJson());

class FlowModel {
  FlowModel({
    @required this.success,
    @required this.data,
    @required this.message,
  });

  bool? success;
  FlowModelData? data;
  String? message;

  factory FlowModel.fromJson(Map<String, dynamic> json) => FlowModel(
        success: json["success"],
        data: FlowModelData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
        "message": message,
      };
}

class FlowModelData {
  FlowModelData({
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

  factory FlowModelData.fromJson(Map<String, dynamic> json) => FlowModelData(
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
    @required this.flowDate,
    @required this.flowTime,
    @required this.flow,
  });

  int? stationId;
  int? station;
  String? stationName;
  DateTime? flowDate;
  String? flowTime;
  String? flow;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
      stationId: json["station_id"],
      station: json["station"],
      stationName: json["station_name"],
      flowDate: DateTime.parse(json["flow_date"]),
      flowTime: json["ft"],
      flow: json["average_f"].toString());

  Map<String, dynamic> toJson() => {
        "station_id": stationId,
        "station": station,
        "station_name": stationNameValues.reverse[stationName],
        "flow_date":
            "${flowDate!.year.toString().padLeft(4, '0')}-${flowDate!.month.toString().padLeft(2, '0')}-${flowDate!.day.toString().padLeft(2, '0')}",
        "ft": flowTime,
        "average_f": flowValues.reverse[flow],
      };
}

enum Flow { EMPTY, THE_028, FLOW, THE_000, THE_010 }

final flowValues = EnumValues({
  "***": Flow.EMPTY,
  "": Flow.FLOW,
  "0.00": Flow.THE_000,
  "0.10": Flow.THE_010,
  "0.28": Flow.THE_028
});

enum StationName {
  MRANGGEN,
  KOPEN,
  GIMBAL,
  KALIURANG,
  PULOWATU,
  GEMER2,
  SALAMSARI,
  TRONO,
  KAJANGKOSO
}

final stationNameValues = EnumValues({
  "Gemer2": StationName.GEMER2,
  "Gimbal": StationName.GIMBAL,
  "Kajangkoso": StationName.KAJANGKOSO,
  "Kaliurang": StationName.KALIURANG,
  "Kopen": StationName.KOPEN,
  "Mranggen": StationName.MRANGGEN,
  "Pulowatu": StationName.PULOWATU,
  "Salamsari": StationName.SALAMSARI,
  "Trono": StationName.TRONO
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
