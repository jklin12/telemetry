// To parse this JSON data, do
//
//     final absensiStoreModel = absensiStoreModelFromJson(jsonString);

import 'dart:convert';

AbsensiStoreModel absensiStoreModelFromJson(String str) =>
    AbsensiStoreModel.fromJson(json.decode(str));

String absensiStoreModelToJson(AbsensiStoreModel data) =>
    json.encode(data.toJson());

class AbsensiStoreModel {
  AbsensiStoreModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory AbsensiStoreModel.fromJson(Map<String, dynamic> json) =>
      AbsensiStoreModel(
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
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.absenTime,
    required this.absenFile,
    required this.createdBy,
    required this.updatedBy,
    required this.updatedAt,
    required this.createdAt,
    required this.absenId,
  });

  String userId;
  String latitude;
  String longitude;
  String absenTime;
  String absenFile;
  int createdBy;
  int updatedBy;
  DateTime updatedAt;
  DateTime createdAt;
  int absenId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        absenTime: json["absen_time"],
        absenFile: json["absen_file"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        absenId: json["absen_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "latitude": latitude,
        "longitude": longitude,
        "absen_time": absenTime,
        "absen_file": absenFile,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "absen_id": absenId,
      };
}
