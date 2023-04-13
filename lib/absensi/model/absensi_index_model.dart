// To parse this JSON data, do
//
//     final absensiIndexModel = absensiIndexModelFromJson(jsonString);

import 'dart:convert';

AbsensiIndexModel absensiIndexModelFromJson(String str) =>
    AbsensiIndexModel.fromJson(json.decode(str));

String absensiIndexModelToJson(AbsensiIndexModel data) =>
    json.encode(data.toJson());

class AbsensiIndexModel {
  AbsensiIndexModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory AbsensiIndexModel.fromJson(Map<String, dynamic> json) =>
      AbsensiIndexModel(
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
    required this.absenId,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.absenFile,
    required this.absenTime,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  int absenId;
  int userId;
  String latitude;
  String longitude;
  String absenFile;
  String absenTime;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        absenId: json["absen_id"],
        userId: json["user_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        absenFile: json["absen_file"],
        absenTime: json["absen_time"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "absen_id": absenId,
        "user_id": userId,
        "latitude": latitude,
        "longitude": longitude,
        "absen_file": absenFile,
        "absen_time": absenTime,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.isAdmin,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  int isAdmin;
  dynamic createdAt;
  dynamic updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        isAdmin: json["isAdmin"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "isAdmin": isAdmin,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
