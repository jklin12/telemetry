// To parse this JSON data, do
//
//     final hytrographModel = hytrographModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

HytrographModel hytrographModelFromJson(String str) =>
    HytrographModel.fromJson(json.decode(str));

String hytrographModelToJson(HytrographModel data) =>
    json.encode(data.toJson());

class HytrographModel {
  HytrographModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory HytrographModel.fromJson(Map<String, dynamic> json) =>
      HytrographModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.title,
    this.subTitle,
    this.filterDate,
    this.filterStation,
    this.filterInterval,
    this.stationList,
    this.data,
  });

  String? title;
  String? subTitle;
  DateTime? filterDate;
  int? filterStation;
  String? filterInterval;
  List<StationList>? stationList;
  List<DataData>? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        subTitle: json["subTitle"],
        filterDate: DateTime.parse(json["filterDate"]),
        filterStation: json["filterStation"],
        filterInterval: json["filterInterval"],
        stationList: List<StationList>.from(
            json["station_list"].map((x) => StationList.fromJson(x))),
        data: List<DataData>.from(json["data"].map((x) => DataData.fromJson(x)))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "filterDate":
            "${filterDate!.year.toString().padLeft(4, '0')}-${filterDate!.month.toString().padLeft(2, '0')}-${filterDate!.day.toString().padLeft(2, '0')}",
        "filterStation": filterStation,
        "filterInterval": filterInterval,
        "station_list": List<dynamic>.from(stationList!.map((x) => x.toJson())),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataData {
  DataData({
    this.rh,
    this.rc,
    this.label,
  });

  double? rh;
  double? rc;
  String? label;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        rh: double.parse(json["rh"].toString()),
        rc: double.parse(json["rc"].toString()),
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "rh": rh,
        "rc": rc,
        "label": label,
      };
}

class StationList {
  StationList({
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
    this.stationIcon,
    this.stationAlert,
    this.stationAlertColumn,
  });

  int? stationId;
  String? stationName;
  String? stationLat;
  String? stationLong;
  String? stationRiver;
  String? stationEquipment;
  String? stationProdYear;
  Station? stationInstalatonDate;
  Station? stationAuthority;
  String? stationGuardsman;
  String? stationRegNumber;
  String? stationIcon;
  String? stationAlert;
  String? stationAlertColumn;

  factory StationList.fromJson(Map<String, dynamic> json) => StationList(
        stationId: json["station_id"],
        stationName: json["station_name"],
        stationLat: json["station_lat"],
        stationLong: json["station_long"],
        stationRiver: json["station_river"],
        stationEquipment: json["station_equipment"],
        stationProdYear: json["station_prod_year"],
        stationInstalatonDate:
            stationValues.map[json["station_instalaton_date"]],
        stationAuthority: stationValues.map[json["station_authority"]],
        stationGuardsman: json["station_guardsman"],
        stationRegNumber: json["station_reg_number"],
        stationIcon: json["station_icon"],
        stationAlert: json["station_alert"],
        stationAlertColumn: json["station_alert_column"],
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
        "station_icon": stationIcon,
        "station_alert": stationAlert,
        "station_alert_column": stationAlertColumn,
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
