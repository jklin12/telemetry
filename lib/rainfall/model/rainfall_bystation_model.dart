// To parse this JSON data, do
//
//     final rainfallByStationModel = rainfallByStationModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'package:meta/meta.dart';
import 'dart:convert';

RainfallByStationModel rainfallByStationModelFromJson(String str) =>
    RainfallByStationModel.fromJson(json.decode(str));

String rainfallByStationModelToJson(RainfallByStationModel data) =>
    json.encode(data.toJson());

class RainfallByStationModel {
  RainfallByStationModel({
    @required this.success,
    @required this.data,
    @required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory RainfallByStationModel.fromJson(Map<String, dynamic> json) =>
      RainfallByStationModel(
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
    @required this.title,
    @required this.subTitle,
    @required this.rainfall,
  });

  String? title;
  String? subTitle;
  List<Rainfall>? rainfall;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        subTitle: json["subTitle"],
        rainfall: List<Rainfall>.from(
            json["rainfall"].map((x) => Rainfall.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "rainfall": List<dynamic>.from(rainfall!.map((x) => x.toJson())),
      };
}

class Rainfall {
  Rainfall({
    @required this.rainFallId,
    @required this.station,
    @required this.rainFallDate,
    @required this.rainFallTime,
    @required this.rainFall10Minut,
    @required this.rainFall30Minute,
    @required this.rainFall1Hour,
    @required this.rainFall3Hour,
    @required this.rainFall6Hour,
    @required this.rainFall12Hour,
    @required this.rainFall24Hour,
    @required this.rainFallContinuous,
    @required this.rainFallEffective,
    @required this.rainFallEffectiveIntensity,
    @required this.rainFallPrevWorking,
    @required this.rainFallWorking,
    @required this.rainFallWorking24,
    @required this.rainFallRemarks,
    @required this.stationId,
    @required this.stationName,
    @required this.stationLat,
    @required this.stationLong,
    @required this.stationRiver,
    @required this.stationEquipment,
    @required this.stationProdYear,
    @required this.stationInstalatonDate,
    @required this.stationAuthority,
    @required this.stationGuardsman,
    @required this.stationRegNumber,
    @required this.stationIcon,
  });

  int? rainFallId;
  int? station;
  RainFallDate? rainFallDate;
  String? rainFallTime;
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
  int? stationId;
  String? stationName;
  String? stationLat;
  String? stationLong;
  String? stationRiver;
  String? stationEquipment;
  String? stationProdYear;
  String? stationInstalatonDate;
  String? stationAuthority;
  String? stationGuardsman;
  String? stationRegNumber;
  String? stationIcon;

  factory Rainfall.fromJson(Map<String, dynamic> json) => Rainfall(
        rainFallId: json["rain_fall_id"],
        station: json["station"],
        rainFallDate: rainFallDateValues.map[json["rain_fall_date"]],
        rainFallTime: json["rt"],
        rainFall10Minut: json["rain_fall_10_minut"].toString(),
        rainFall30Minute: json["rain_fall_30_minute"].toString(),
        rainFall1Hour: json["rain_fall_1_hour"].toString(),
        rainFall3Hour: json["rain_fall_3_hour"].toString(),
        rainFall6Hour: json["rain_fall_6_hour"].toString(),
        rainFall12Hour: json["rain_fall_12_hour"].toString(),
        rainFall24Hour: json["rain_fall_24_hour"].toString(),
        rainFallContinuous: json["rain_fall_continuous"].toString(),
        rainFallEffective: json["rain_fall_effective"].toString(),
        rainFallEffectiveIntensity:
            json["rain_fall_effective_intensity"].toString(),
        rainFallPrevWorking: json["rain_fall_prev_working"].toString(),
        rainFallWorking: json["rain_fall_working"].toString(),
        rainFallWorking24: json["rain_fall_working_24"].toString(),
        rainFallRemarks: json["rain_fall_remarks"],
        stationId: json["station_id"],
        stationName: json["station_name"],
        stationLat: json["station_lat"],
        stationLong: json["station_long"],
        stationRiver: json["station_river"],
        stationEquipment: json["station_equipment"],
        stationProdYear: json["station_prod_year"],
        stationInstalatonDate: json["station_instalaton_date"],
        stationAuthority: json["station_authority"],
        stationGuardsman: json["station_guardsman"],
        stationRegNumber: json["station_reg_number"],
        stationIcon: json["station_icon"],
      );

  Map<String, dynamic> toJson() => {
        "rain_fall_id": rainFallId,
        "station": station,
        "rain_fall_date": rainFallDateValues.reverse[rainFallDate],
        "rt": rainFallTime,
        "rain_fall_10_minut": rainFall10Minut,
        "rain_fall_30_minute": rainFall30Minute,
        "rain_fall_1_hour": rainFallValues.reverse[rainFall1Hour],
        "rain_fall_3_hour": rainFall3Hour,
        "rain_fall_6_hour": rainFall6Hour,
        "rain_fall_12_hour": rainFall12Hour,
        "rain_fall_24_hour": rainFall24Hour,
        "rain_fall_continuous": rainFallValues.reverse[rainFallContinuous],
        "rain_fall_effective": rainFallEffective,
        "rain_fall_effective_intensity": rainFallEffectiveIntensity,
        "rain_fall_prev_working": rainFallPrevWorking,
        "rain_fall_working": rainFallWorking,
        "rain_fall_working_24": rainFallWorking24,
        "rain_fall_remarks": rainFallRemarks,
        "station_id": stationId,
        "station_name": stationNameValues.reverse[stationName],
        "station_lat": stationLatValues.reverse[stationLat],
        "station_long": stationLongValues.reverse[stationLong],
        "station_river": stationRiverValues.reverse[stationRiver],
        "station_equipment": stationEquipmentValues.reverse[stationEquipment],
        "station_prod_year": stationProdYear,
        "station_instalaton_date": stationValues.reverse[stationInstalatonDate],
        "station_authority": stationValues.reverse[stationAuthority],
        "station_guardsman": stationGuardsman,
        "station_reg_number": stationRegNumber,
        "station_icon": stationIconValues.reverse[stationIcon],
      };
}

enum RainFall { THE_0, EMPTY }

final rainFallValues = EnumValues({"": RainFall.EMPTY, "* 0": RainFall.THE_0});

enum RainFallDate { THE_11_AUGUST_2020 }

final rainFallDateValues =
    EnumValues({"11 August 2020": RainFallDate.THE_11_AUGUST_2020});

enum Station { JAN_00 }

final stationValues = EnumValues({"Jan-00": Station.JAN_00});

enum StationEquipment { RG }

final stationEquipmentValues = EnumValues({"RG": StationEquipment.RG});

enum StationIcon { CIRCLE_15 }

final stationIconValues = EnumValues({"circle-15": StationIcon.CIRCLE_15});

enum StationLat { THE_7_O_3515 }

final stationLatValues = EnumValues({"7o 35' 15\"": StationLat.THE_7_O_3515});

enum StationLong { THE_110_O_2556 }

final stationLongValues =
    EnumValues({"110o 25' 56\"": StationLong.THE_110_O_2556});

enum StationName { PLAWANGAN }

final stationNameValues = EnumValues({"Plawangan": StationName.PLAWANGAN});

enum StationRiver { K_BOYONG_K }

final stationRiverValues = EnumValues({"K.Boyong,K": StationRiver.K_BOYONG_K});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
