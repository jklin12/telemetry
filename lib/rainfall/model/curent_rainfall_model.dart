// To parse this JSON data, do
//
//     final curentRainfallModel = curentRainfallModelFromJson(jsonString);

import 'dart:convert';

CurentRainfallModel curentRainfallModelFromJson(String str) =>
    CurentRainfallModel.fromJson(json.decode(str));

String curentRainfallModelToJson(CurentRainfallModel data) =>
    json.encode(data.toJson());

class CurentRainfallModel {
  CurentRainfallModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  CurentRainfallModelData? data;
  String? message;

  factory CurentRainfallModel.fromJson(Map<String, dynamic> json) =>
      CurentRainfallModel(
        success: json["success"],
        data: CurentRainfallModelData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
        "message": message,
      };
}

class CurentRainfallModelData {
  CurentRainfallModelData({
    this.datas,
    this.date,
  });

  List<DataElement>? datas;
  DateTime? date;

  factory CurentRainfallModelData.fromJson(Map<String, dynamic> json) =>
      CurentRainfallModelData(
        datas: List<DataElement>.from(
            json["datas"].map((x) => DataElement.fromJson(x))),
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "datas": List<dynamic>.from(datas!.map((x) => x.toJson())),
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
      };
}

class DataElement {
  DataElement({
    this.rainFallId,
    this.station,
    this.rainFallDate,
    this.rainFall10Minut,
    this.rainFall30Minute,
    this.rainFall1Hour,
    this.rainFall3Hour,
    this.rainFall6Hour,
    this.rainFall12Hour,
    this.rainFall24Hour,
    this.rainFallContinuous,
    this.rainFallEffective,
    this.rainFallEffectiveIntensity,
    this.rainFallPrevWorking,
    this.rainFallWorking,
    this.rainFallWorking24,
    this.rainFallRemarks,
  });

  int? rainFallId;
  String? station;
  DateTime? rainFallDate;
  String? rainFall10Minut;
  String? rainFall30Minute;
  String? rainFall1Hour;
  String? rainFall3Hour;
  String? rainFall6Hour;
  String? rainFall12Hour;
  String? rainFall24Hour;
  String? rainFallContinuous;
  String? rainFallEffective;
  String? rainFallEffectiveIntensity;
  String? rainFallPrevWorking;
  String? rainFallWorking;
  String? rainFallWorking24;
  String? rainFallRemarks;

  factory DataElement.fromJson(Map<String, dynamic> json) => DataElement(
        rainFallId: json["rain_fall_id"],
        station: json["station"],
        rainFallDate: DateTime.parse(json["rain_fall_date"]),
        rainFall10Minut: json["rain_fall_10_minut"],
        rainFall30Minute: json["rain_fall_30_minute"],
        rainFall1Hour: json["rain_fall_1_hour"],
        rainFall3Hour: json["rain_fall_3_hour"],
        rainFall6Hour: json["rain_fall_6_hour"],
        rainFall12Hour: json["rain_fall_12_hour"],
        rainFall24Hour: json["rain_fall_24_hour"],
        rainFallContinuous: json["rain_fall_continuous"],
        rainFallEffective: json["rain_fall_effective"],
        rainFallEffectiveIntensity: json["rain_fall_effective_intensity"],
        rainFallPrevWorking: json["rain_fall_prev_working"],
        rainFallWorking: json["rain_fall_working"],
        rainFallWorking24: json["rain_fall_working_24"],
        rainFallRemarks: json["rain_fall_remarks"],
      );

  Map<String, dynamic> toJson() => {
        "rain_fall_id": rainFallId,
        "station": station,
        "rain_fall_date":
            "${rainFallDate!.year.toString().padLeft(4, '0')}-${rainFallDate!.month.toString().padLeft(2, '0')}-${rainFallDate!.day.toString().padLeft(2, '0')}",
        "rain_fall_10_minut": rainFall10Minut,
        "rain_fall_30_minute": rainFall30Minute,
        "rain_fall_1_hour": rainFall1Hour,
        "rain_fall_3_hour": rainFall3Hour,
        "rain_fall_6_hour": rainFall6Hour,
        "rain_fall_12_hour": rainFall12Hour,
        "rain_fall_24_hour": rainFall24Hour,
        "rain_fall_continuous": rainFallContinuous,
        "rain_fall_effective": rainFallEffective,
        "rain_fall_effective_intensity": rainFallEffectiveIntensity,
        "rain_fall_prev_working": rainFallPrevWorking,
        "rain_fall_working": rainFallWorking,
        "rain_fall_working_24": rainFallWorking24,
        "rain_fall_remarks": rainFallRemarks,
      };
}
