import 'package:bengkelly_apps/model/merk_vehicle.dart';

class MerkType {
  bool? status;
  String? message;
  List<TypeVehicle>? data;

  MerkType({
    this.status,
    this.message,
    this.data,
  });

  MerkType.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] == null
        ? null
        : List<TypeVehicle>.from(
            json['data'].map((x) => TypeVehicle.fromJson(x)));
  }
}

class TypeVehicle {
  int? id;
  String? nameType;
  int? deleted;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  Merk? merk;

  TypeVehicle(
      {this.id,
      this.nameType,
      this.deleted,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.merk});

  TypeVehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'];
    nameType = json['nama_tipe'] ?? '';
    deleted = json['deleted'];
    createdBy = json['created_by'] == null ? null : json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    merk = json['merk'] == null ? null : Merk.fromJson(json['merk']);
  }

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "nama_tipe": nameType,
  //       "deleted": deleted,
  //       "created_by": createdBy,
  //       "created_at": createdAt,
  //       "updated_at": updatedAt,
  //       "merk": merk,
  //     };
}
