// To parse this JSON data, do
//
//     final dailyRainfallModel = dailyRainfallModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

DailyRainfallModel dailyRainfallModelFromJson(String str) =>
    DailyRainfallModel.fromJson(json.decode(str));

String dailyRainfallModelToJson(DailyRainfallModel data) =>
    json.encode(data.toJson());

class DailyRainfallModel {
  DailyRainfallModel({
    this.title,
    this.subTitle,
    this.station,
    this.rainfall,
  });

  String? title;
  String? subTitle;
  List<Station>? station;
  List<Rainfall>? rainfall;

  factory DailyRainfallModel.fromJson(Map<String, dynamic> json) =>
      DailyRainfallModel(
        title: json["data"]["title"],
        subTitle: json["data"]["subTitle"],
        station: List<Station>.from(
            json["data"]["station"].map((x) => Station.fromJson(x))),
        rainfall: List<Rainfall>.from(
            json["data"]["rainfall"].map((x) => Rainfall.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "station": List<dynamic>.from(station!.map((x) => x.toJson())),
        "rainfall": List<dynamic>.from(rainfall!.map((x) => x.toJson())),
      };
}

class Rainfall {
  Rainfall({
    this.dateTime,
    this.datas,
  });

  String? dateTime;
  List<Data>? datas;

  factory Rainfall.fromJson(Map<String, dynamic> json) => Rainfall(
        dateTime: json["date_time"],
        datas: List<Data>.from(json["datas"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date_time": dateTime,
        "datas": List<dynamic>.from(datas!.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    this.station,
    this.rainFallDate,
    this.rainFallTime,
    this.stationName,
    this.rainFall1Hour,
    this.rainFallContinuous,
  });

  int? station;
  DateTime? rainFallDate;
  String? rainFallTime;
  String? stationName;
  String? rainFall1Hour;
  String? rainFallContinuous;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        station: json["station"],
        rainFallDate: DateTime.parse(json["rain_fall_date"]),
        rainFallTime: json["rain_fall_time"],
        stationName: json["rt"],
        rainFall1Hour: json["average_rh"].toString(),
        rainFallContinuous: json["average_rc"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "station": station,
        "rain_fall_date":
            "${rainFallDate!.year.toString().padLeft(4, '0')}-${rainFallDate!.month.toString().padLeft(2, '0')}-${rainFallDate!.day.toString().padLeft(2, '0')}",
        "rain_fall_time": rainFallTime,
        "rt": stationNameValues.reverse[stationName],
        "average_rh": rainFallValues.reverse[rainFall1Hour],
        "average_rc": rainFallValues.reverse[rainFallContinuous],
      };
}

enum RainFall { THE_0, EMPTY }

final rainFallValues = EnumValues({"": RainFall.EMPTY, "* 0": RainFall.THE_0});

enum StationName { G_MARON, PLAWANGAN, MRANGGEN, BABADAN, GEMER1, KALIADEM }

final stationNameValues = EnumValues({
  "Babadan": StationName.BABADAN,
  "Gemer1": StationName.GEMER1,
  "G.Maron": StationName.G_MARON,
  "Kaliadem": StationName.KALIADEM,
  "Mranggen": StationName.MRANGGEN,
  "Plawangan": StationName.PLAWANGAN
});

class Station {
  Station({
    this.stationName,
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
