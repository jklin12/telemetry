// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  HistoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.historyId,
    required this.station,
    required this.assets,
    required this.historyTitle,
    required this.historyBody,
    required this.historyTumbnial,
    required this.historyImgae,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.stations,
  });

  int historyId;
  String station;
  String? assets;
  String historyTitle;
  String? historyBody;
  String? historyTumbnial;
  String? historyImgae;
  int createdBy;
  int updatedBy;
  String createdAt;
  String updatedAt;
  Stations stations;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        historyId: json["history_id"],
        station: json["station"],
        assets: json["assets"],
        historyTitle: json["history_title"],
        historyBody: json["history_body"],
        historyTumbnial: json["history_tumbnial"],
        historyImgae: json["history_imgae"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        stations: Stations.fromJson(json["stations"]),
      );

  Map<String, dynamic> toJson() => {
        "history_id": historyId,
        "station": station,
        "assets": assets,
        "history_title": historyTitle,
        "history_body": historyBody,
        "history_tumbnial": historyTumbnial,
        "history_imgae": historyImgae,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "stations": stations.toJson(),
        //"asset": asset!.toJson(),
      };
}

class Asset {
  Asset({
    required this.assetsId,
    required this.station,
    required this.assetName,
    required this.assetBrand,
    required this.assetType,
    required this.assetSerialNumber,
    required this.assetSpesification,
    required this.assetYear,
    required this.assetTumbnial,
    required this.assetImgae,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  int assetsId;
  String station;
  String? assetName;
  String? assetBrand;
  String? assetType;
  String? assetSerialNumber;
  String? assetSpesification;
  String? assetYear;
  String? assetTumbnial;
  String? assetImgae;
  int createdBy;
  int updatedBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        assetsId: json["assets_id"],
        station: json["station"],
        assetName: json["asset_name"],
        assetBrand: json["asset_brand"],
        assetType: json["asset_type"],
        assetSerialNumber: json["asset_serial_number"],
        assetSpesification: json["asset_spesification"],
        assetYear: json["asset_year"],
        assetTumbnial: json["asset_tumbnial"],
        assetImgae: json["asset_imgae"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "assets_id": assetsId,
        "station": station,
        "asset_name": assetName,
        "asset_brand": assetBrand,
        "asset_type": assetType,
        "asset_serial_number": assetSerialNumber,
        "asset_spesification": assetSpesification,
        "asset_year": assetYear,
        "asset_tumbnial": assetTumbnial,
        "asset_imgae": assetImgae,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Stations {
  Stations({
    required this.stationId,
    required this.stationName,
    required this.stationLat,
    required this.stationLong,
    required this.stationRiver,
    required this.stationEquipment,
    required this.stationProdYear,
    required this.stationInstalatonDate,
    required this.stationAuthority,
    required this.stationGuardsman,
    required this.stationRegNumber,
    required this.stationIcon,
    required this.stationAlert,
    required this.stationAlertColumn,
  });

  int stationId;
  String stationName;
  String stationLat;
  String stationLong;
  String stationRiver;
  String stationEquipment;
  String stationProdYear;
  String stationInstalatonDate;
  String stationAuthority;
  String stationGuardsman;
  String stationRegNumber;
  String stationIcon;
  String stationAlert;
  String stationAlertColumn;

  factory Stations.fromJson(Map<String, dynamic> json) => Stations(
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
        "station_instalaton_date": stationInstalatonDate,
        "station_authority": stationAuthority,
        "station_guardsman": stationGuardsman,
        "station_reg_number": stationRegNumber,
        "station_icon": stationIcon,
        "station_alert": stationAlert,
        "station_alert_column": stationAlertColumn,
      };
}
