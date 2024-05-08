// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  bool? status;
  String? message;
  Data? data;

  UserData({
     this.status,
     this.message,
     this.data,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? nama;
  String? hp;
  String? email;
  String? alamat;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? gambar;
  Data({
     this.id,
     this.nama,
     this.hp,
     this.email,
     this.alamat,
     this.createdAt,
     this.updatedAt,
    this.gambar,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    nama: json["nama"],
    hp: json["hp"],
    email: json["email"],
    alamat: json["alamat"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    gambar: json['gambar'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "hp": hp,
    "email": email,
    "alamat": alamat,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "gambar": gambar,
  };
}
