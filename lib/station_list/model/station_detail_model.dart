// To parse this JSON data, do
//
//     final stationDetailModel = stationDetailModelFromJson(jsonString);

import 'dart:convert';

StationDetailModel stationDetailModelFromJson(String str) =>
    StationDetailModel.fromJson(json.decode(str));

String stationDetailModelToJson(StationDetailModel data) =>
    json.encode(data.toJson());

class StationDetailModel {
  StationDetailModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory StationDetailModel.fromJson(Map<String, dynamic> json) =>
      StationDetailModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.station,
    required this.stationAsset,
    required this.stationHistory,
  });

  Station station;
  List<Asset> stationAsset;
  List<StationHistory> stationHistory;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        station: Station.fromJson(json["station"]),
        stationAsset: List<Asset>.from(
            json["station_asset"].map((x) => Asset.fromJson(x))),
        stationHistory: List<StationHistory>.from(
            json["station_history"].map((x) => StationHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "station": station.toJson(),
        "station_asset":
            List<dynamic>.from(stationAsset.map((x) => x.toJson())),
        "station_history":
            List<dynamic>.from(stationHistory.map((x) => x.toJson())),
      };
}

class Station {
  Station({
    required this.stationId,
    required this.stationName,
    required this.stationLat,
    required this.stationLong,
    required this.stationRiver,
    required this.stationProdYear,
    required this.stationInstalatonText,
    required this.stationAuthority,
    required this.stationRegNumber,
    required this.stationGuardsman,
    required this.stationTypes,
  });

  int stationId;
  String stationName;
  String stationLat;
  String stationLong;
  String stationRiver;
  String stationProdYear;
  dynamic stationInstalatonText;
  String stationAuthority;
  String stationRegNumber;
  String stationGuardsman;
  List<StationTypes> stationTypes;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        stationId: json["station_id"],
        stationName: json["station_name"]!,
        stationLat: json["station_lat"]!,
        stationLong: json["station_long"]!,
        stationRiver: json["station_river"]!,
        stationProdYear: json["station_prod_year"],
        stationInstalatonText: json["station_instalaton_text"],
        stationAuthority: json["station_authority"]!,
        stationRegNumber: json["station_reg_number"],
        stationGuardsman: json["station_guardsman"],
        stationTypes: json["station_types"] != null
            ? List<StationTypes>.from(
                json["station_types"].map((x) => StationTypes.fromJson(x)))
            : List<StationTypes>.empty(),
      );

  Map<String, dynamic> toJson() => {
        "station_id": stationId,
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
    //required this.stations,
  });

  int assetsId;
  String station;
  String assetName;
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
  //Station stations;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        assetsId: json["assets_id"],
        station: json["station"],
        assetName: json["asset_name"],
        assetBrand: json["asset_brand"] ?? '',
        assetType: json["asset_type"] ?? '',
        assetSerialNumber: json["asset_serial_number"] ?? '',
        assetSpesification: json["asset_spesification"] ?? '',
        assetYear: json["asset_year"] ?? '',
        assetTumbnial: json["asset_tumbnial"] ?? '',
        assetImgae: json["asset_imgae"] ?? '',
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        //stations: Station.fromJson(json["stations"]) ?? Station,
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
        //"stations": stations.toJson(),
      };
}

class StationHistory {
  StationHistory({
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
    //required this.asset,
  });

  int historyId;
  String station;
  String assets;
  String historyTitle;
  dynamic historyBody;
  String historyTumbnial;
  String historyImgae;
  int createdBy;
  int updatedBy;
  String createdAt;
  String updatedAt;
  Station stations;
  //Asset asset;

  factory StationHistory.fromJson(Map<String, dynamic> json) => StationHistory(
        historyId: json["history_id"],
        station: json["station"],
        assets: json["assets"] ?? '',
        historyTitle: json["history_title"] ?? '',
        historyBody: json["history_body"] ?? '',
        historyTumbnial: json["history_tumbnial"] ?? '',
        historyImgae: json["history_imgae"] ?? '',
        createdBy: json["created_by"] ?? '',
        updatedBy: json["updated_by"] ?? '',
        createdAt: json["created_at"]!,
        updatedAt: json["updated_at"]!,
        stations: Station.fromJson(json["stations"]),
        //asset: Asset.fromJson(json["asset"]),
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
        //"asset": asset.toJson(),
      };
}

// To parse this JSON data, do
//
//     final stationTypes = stationTypesFromJson(jsonString);

class StationTypes {
  StationTypes({
    required this.id,
    required this.stationType,
    required this.alertColumn,
    required this.alertValue,
  });

  int id;
  String stationType;
  dynamic alertColumn;
  String alertValue;

  factory StationTypes.fromJson(Map<String, dynamic> json) => StationTypes(
        id: json["id"],
        stationType: json["station_type"],
        alertColumn: json["alert_column"],
        alertValue: json["alert_value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "station_type": stationType,
        "alert_column": alertColumn,
        "alert_value": alertValue,
      };
}
