// To parse this JSON data, do
//
//     final getService = getServiceFromJson(jsonString);

import 'dart:convert';

GetService getServiceFromJson(String str) =>
    GetService.fromJson(json.decode(str));

String getServiceToJson(GetService data) => json.encode(data.toJson());

class GetService {
  bool? status;
  String? message;
  List<Service>? data;

  GetService({
    this.status,
    this.message,
    this.data,
  });

  factory GetService.fromJson(Map<String, dynamic> json) => GetService(
        status: json["status"],
        message: json["message"],
        data: List<Service>.from(json["data"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
      };
}

class Service {
  int? id;
  String? namaJenissvc;
  int? deleted;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Service({
    this.id,
    this.namaJenissvc,
    this.deleted,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        namaJenissvc: json["nama_jenissvc"],
        deleted: json["deleted"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_jenissvc": namaJenissvc,
        "deleted": deleted,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
