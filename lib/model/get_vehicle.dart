// To parse this JSON data, do
//
//     final getVehicle = getVehicleFromJson(jsonString);

import 'dart:convert';

GetVehicle getVehicleFromJson(String str) => GetVehicle.fromJson(json.decode(str));

String getVehicleToJson(GetVehicle data) => json.encode(data.toJson());

class GetVehicle {
  bool? status;
  String? message;
  List<Vehicle>? data;

  GetVehicle({
     this.status,
     this.message,
     this.data,
  });

  factory GetVehicle.fromJson(Map<String, dynamic> json) => GetVehicle(
    status: json["status"],
    message: json["message"],
    data: List<Vehicle>.from(json["data"].map((x) => Vehicle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
  };
}

class Vehicle {
  int? id;
  dynamic kode;
  dynamic kodePelanggan;
  String? noPolisi;
  int? idMerk;
  int? idTipe;
  String? tahun;
  String? warna;
  dynamic transmisi;
  dynamic noRangka;
  dynamic noMesin;
  dynamic modelKaroseri;
  dynamic drivingMode;
  dynamic power;
  String? kategoriKendaraan;
  dynamic jenisKontrak;
  int? deleted;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? idCustomer;
  Merks? merks;
  List<Tipe>? tipes;

  Vehicle({
     this.id,
     this.kode,
     this.kodePelanggan,
     this.noPolisi,
     this.idMerk,
     this.idTipe,
     this.tahun,
     this.warna,
     this.transmisi,
     this.noRangka,
     this.noMesin,
     this.modelKaroseri,
     this.drivingMode,
     this.power,
     this.kategoriKendaraan,
     this.jenisKontrak,
     this.deleted,
     this.createdBy,
     this.createdAt,
     this.updatedAt,
     this.idCustomer,
     this.merks,
     this.tipes,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json["id"],
    kode: json["kode"],
    kodePelanggan: json["kode_pelanggan"],
    noPolisi: json["no_polisi"],
    idMerk: json["id_merk"],
    idTipe: json["id_tipe"],
    tahun: json["tahun"],
    warna: json["warna"],
    transmisi: json["transmisi"],
    noRangka: json["no_rangka"],
    noMesin: json["no_mesin"],
    modelKaroseri: json["model_karoseri"],
    drivingMode: json["driving_mode"],
    power: json["power"],
    kategoriKendaraan: json["kategori_kendaraan"],
    jenisKontrak: json["jenis_kontrak"],
    deleted: json["deleted"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]) != null ? DateTime.parse(json["updated_at"]) : null,
    idCustomer: json["id_customer"],
    merks: Merks.fromJson(json["merks"]),
    tipes: List<Tipe>.from(json["tipes"].map((x) => Tipe.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kode": kode,
    "kode_pelanggan": kodePelanggan,
    "no_polisi": noPolisi,
    "id_merk": idMerk,
    "id_tipe": idTipe,
    "tahun": tahun,
    "warna": warna,
    "transmisi": transmisi,
    "no_rangka": noRangka,
    "no_mesin": noMesin,
    "model_karoseri": modelKaroseri,
    "driving_mode": drivingMode,
    "power": power,
    "kategori_kendaraan": kategoriKendaraan,
    "jenis_kontrak": jenisKontrak,
    "deleted": deleted,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "id_customer": idCustomer,
    "merks": merks?.toJson(),
    "tipes": List<dynamic>.from(tipes?.map((x) => x.toJson()) ?? []),
  };
}

class Merks {
  int? id;
  String? namaMerk;

  Merks({
     this.id,
     this.namaMerk,
  });

  factory Merks.fromJson(Map<String, dynamic> json) => Merks(
    id: json["id"],
    namaMerk: json["nama_merk"] != null ? json['nama_merk'] : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_merk": namaMerk,
  };
}

class Tipe {
  int? id;
  String? namaTipe;

  Tipe({
     this.id,
     this.namaTipe,
  });

  factory Tipe.fromJson(Map<String, dynamic> json) => Tipe(
    id: json["id"],
    namaTipe: json["nama_tipe"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_tipe": namaTipe,
  };
}
