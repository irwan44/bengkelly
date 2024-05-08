class MerkVehicle {
  bool? status;
  String? message;
  List<Merk>? data;

  MerkVehicle({
    this.status,
    this.message,
    this.data,
  });

  MerkVehicle.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] == null
        ? null
        : List<Merk>.from(json['data'].map((x) => Merk.fromJson(x)));
  }

  // Map<String, dynamic> toJson() => {
  //       "status": status,
  //       "message": message,
  //       "data": data == null
  //           ? null
  //           : List<dynamic>.from(data!.map((x) => x.toJson())),
  //     };
}

class Merk {
  int? id;
  String? nameMerk;
  int? deleted;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  Merk({
    this.id,
    this.nameMerk,
    this.deleted,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  Merk.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'];
    nameMerk = json['nama_merk'];
    deleted = json['deleted'];
    createdBy = json['created_by'] == null ? null : json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "nama_merk": nameMerk,
  //       "deleted": deleted,
  //       "created_by": createdBy,
  //       "created_at": createdAt,
  //       "updated_at": updatedAt,
  //     };
}
