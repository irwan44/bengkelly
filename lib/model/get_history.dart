import 'dart:convert';

GetHistory getHistoryFromJson(String str) =>
    GetHistory.fromJson(json.decode(str));

String getHistoryToJson(GetHistory data) => json.encode(data.toJson());

class GetHistory {
  bool? status;
  String? message;
  List<History>? data;

  GetHistory({
    this.status,
    this.message,
    this.data,
  });

  factory GetHistory.fromJson(Map<String, dynamic> json) => GetHistory(
        status: json["status"],
        message: json["message"],
        data: List<History>.from(json["data"].map((x) => History.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
      };
}

class History {
  int? id;
  String? namaPelanggan;
  String? namaCabang;
  String? noPolisi;
  String? status;
  String? alamat;
  String? namaJenissvc;
  List<Jasa>? jasa;
  List<Part>? part;
  String? message;

  History({
    this.id,
    this.namaPelanggan,
    this.namaCabang,
    this.noPolisi,
    this.status,
    this.namaJenissvc,
    this.jasa,
    this.alamat,
    this.part,
    this.message,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        namaPelanggan: json["nama_pelanggan"],
        namaCabang: json["nama_cabang"],
        noPolisi: json["no_polisi"],
        status: json["nama_status"],
        alamat: json["alamat"],
        namaJenissvc: json["nama_jenissvc"],
        jasa: List<Jasa>.from(json["jasa"].map((x) => Jasa.fromJson(x))),
        part: List<Part>.from(json["part"].map((x) => Part.fromJson(x))),
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_pelanggan": namaPelanggan,
        "nama_cabang": namaCabang,
        "no_polisi": noPolisi,
        "alamat": alamat,
        "nama_status": status,
        "nama_jenissvc": namaJenissvc,
        "jasa": List<dynamic>.from(jasa?.map((x) => x.toJson()) ?? []),
        "part": List<dynamic>.from(part?.map((x) => x) ?? []),
        "message": message,
      };
}

class Jasa {
  DateTime? tgl;
  String? kodeJasa;
  String? namaJasa;
  int? qtyJasa;
  int? harga;

  Jasa({
    this.tgl,
    this.kodeJasa,
    this.namaJasa,
    this.qtyJasa,
    this.harga,
  });

  factory Jasa.fromJson(Map<String, dynamic> json) => Jasa(
        tgl: DateTime.parse(json["tgl"]),
        kodeJasa: json["kode_jasa"],
        namaJasa: json["nama_jasa"],
        qtyJasa: json["qty_jasa"],
        harga: json["harga"],
      );

  Map<String, dynamic> toJson() => {
        "tgl":
            "${tgl?.year.toString().padLeft(4, '0')}-${tgl?.month.toString().padLeft(2, '0')}-${tgl?.day.toString().padLeft(2, '0')}",
        "kode_jasa": kodeJasa,
        "nama_jasa": namaJasa,
        "qty_jasa": qtyJasa,
        "harga": harga,
      };
}

class Part {
  DateTime? tgl;
  String? kodeSparepart;
  String? namaSparepart;
  int? qtySparepart;
  int? harga;

  Part({
    this.tgl,
    this.kodeSparepart,
    this.namaSparepart,
    this.qtySparepart,
    this.harga,
  });

  factory Part.fromJson(Map<String, dynamic> json) => Part(
        tgl: DateTime.parse(json["tgl"]),
        kodeSparepart: json["kode_sparepart"],
        namaSparepart: json["nama_sparepart"],
        qtySparepart: json["qty_sparepart"],
        harga: json["harga"],
      );

  Map<String, dynamic> toJson() => {
        "tgl":
            "${tgl?.year.toString().padLeft(4, '0')}-${tgl?.month.toString().padLeft(2, '0')}-${tgl?.day.toString().padLeft(2, '0')}",
        "kode_sparepart": kodeSparepart,
        "nama_sparepart": namaSparepart,
        "qty_sparepart": qtySparepart,
        "harga": harga,
      };
}

// // To parse this JSON data, do
// //
// //     final getHistory = getHistoryFromJson(jsonString);
//
// import 'dart:convert';
//
// GetHistory getHistoryFromJson(String str) =>
//     GetHistory.fromJson(json.decode(str));
//
// String getHistoryToJson(GetHistory data) => json.encode(data.toJson());
//
// class GetHistory {
//   bool? status;
//   String? message;
//   List<History>? data;
//
//   GetHistory({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory GetHistory.fromJson(Map<String, dynamic> json) => GetHistory(
//         status: json["status"],
//         message: json["message"],
//         data: List<History>.from(json["data"].map((x) => History.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
//       };
// }
//
// class History {
//   int? id;
//   String? kode;
//   String? kodeBooking;
//   int? idJenissvc;
//   String? status;
//   String? kodeSvc;
//   String? noPolisiFaktur;
//   int? jmlPart;
//   int? jmlJasa;
//   int? jmlPaket;
//   dynamic tambahan;
//   int? jmlTambahan;
//   // DateTime? jtFakturSvc;
//   dynamic noFakturPajak;
//   int? total;
//   int? lunas;
//   int? bayar;
//   String? ppn;
//   dynamic pph;
//   int? materai;
//   int? deleted;
//   String? createdBy;
//   DateTime? createdAt;
//   dynamic updatedAt;
//   String? namaMerk;
//   String? namaTipe;
//   String? tahun;
//   String? warna;
//   // List<Jasa>? jasa;
//   // List<Part>? datumPart;
//   JenisService? jenisService;
//   Cabang? cabang;
//   History({
//     this.id,
//     this.kode,
//     this.kodeSvc,
//     this.noPolisiFaktur,
//     this.jmlPart,
//     this.jmlJasa,
//     this.jmlPaket,
//     this.tambahan,
//     this.jmlTambahan,
//     // this.jtFakturSvc,
//     this.noFakturPajak,
//     this.total,
//     this.lunas,
//     this.bayar,
//     this.ppn,
//     this.pph,
//     this.materai,
//     this.deleted,
//     this.createdBy,
//     this.createdAt,
//     this.updatedAt,
//     this.namaMerk,
//     this.namaTipe,
//     this.tahun,
//     this.warna,
//     // this.jasa,
//     // this.datumPart,
//     this.kodeBooking,
//     this.idJenissvc,
//     this.status,
//     this.jenisService,
//     this.cabang,
//   });
//
//   factory History.fromJson(Map<String, dynamic> json) => History(
//         id: json["id"],
//         idJenissvc: json['id_jenissvc'],
//         kodeBooking: json['kode_booking'],
//         kode: json["kode"] != null ? json["kode"] : null,
//         kodeSvc: json["kode_svc"],
//         noPolisiFaktur: json["no_polisi_faktur"],
//         jmlPart: json["jml_part"],
//         jmlJasa: json["jml_jasa"],
//         jmlPaket: json["jml_paket"],
//         tambahan: json["tambahan"],
//         jmlTambahan: json["jml_tambahan"],
//         // jtFakturSvc: DateTime.parse(json["jt_faktur_svc"]),
//         noFakturPajak: json["no_faktur_pajak"],
//         total: json["total"],
//         lunas: json["lunas"],
//         bayar: json["bayar"],
//         ppn: json["ppn"],
//         pph: json["pph"],
//         materai: json["materai"],
//         deleted: json["deleted"],
//         createdBy: json["created_by"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"],
//         namaMerk: json["nama_merk"],
//         namaTipe: json["nama_tipe"],
//         tahun: json["tahun"],
//         warna: json["warna"],
//         status: json['status'],
//         jenisService: JenisService.fromJson(json['jenis_service']),
//         cabang: Cabang.fromJson(json['cabang']),
//         // jasa: List<Jasa>.from(json["jasa"].map((x) => Jasa.fromJson(x))),
//         // datumPart: List<Part>.from(json["part"].map((x) => Part.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "kode_booking": kodeBooking,
//         "kode": kode,
//         "kode_svc": kodeSvc,
//         "no_polisi_faktur": noPolisiFaktur,
//         "jml_part": jmlPart,
//         "jml_jasa": jmlJasa,
//         "jml_paket": jmlPaket,
//         "tambahan": tambahan,
//         "jml_tambahan": jmlTambahan,
//         // "jt_faktur_svc":
//         //     "${jtFakturSvc?.year.toString().padLeft(4, '0')}-${jtFakturSvc?.month.toString().padLeft(2, '0')}-${jtFakturSvc?.day.toString().padLeft(2, '0')}",
//         "no_faktur_pajak": noFakturPajak,
//         "total": total,
//         "lunas": lunas,
//         "bayar": bayar,
//         "ppn": ppn,
//         "pph": pph,
//         "materai": materai,
//         "deleted": deleted,
//         "created_by": createdBy,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt,
//         "nama_merk": namaMerk,
//         "nama_tipe": namaTipe,
//         "tahun": tahun,
//         "warna": warna,
//         "status": status,
//     "jenis_service": jenisService?.toJson(),
//     "cabang": cabang?.toJson(),
//         // "jasa": List<dynamic>.from(jasa?.map((x) => x.toJson()) ?? []),
//         // "part": List<dynamic>.from(datumPart?.map((x) => x.toJson()) ?? []),
//       };
// }
//
// class Part {
//   DateTime? tgl;
//   String? kodeSparepart;
//   String? namaSparepart;
//   int? qtySparepart;
//   int? harga;
//
//   Part({
//     this.tgl,
//     this.kodeSparepart,
//     this.namaSparepart,
//     this.qtySparepart,
//     this.harga,
//   });
//
//   factory Part.fromJson(Map<String, dynamic> json) => Part(
//         tgl: DateTime.parse(json["tgl"]),
//         kodeSparepart: json["kode_sparepart"],
//         namaSparepart: json["nama_sparepart"],
//         qtySparepart: json["qty_sparepart"],
//         harga: json["harga"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "tgl":
//             "${tgl?.year.toString().padLeft(4, '0')}-${tgl?.month.toString().padLeft(2, '0')}-${tgl?.day.toString().padLeft(2, '0')}",
//         "kode_sparepart": kodeSparepart,
//         "nama_sparepart": namaSparepart,
//         "qty_sparepart": qtySparepart,
//         "harga": harga,
//       };
// }
//
// class Jasa {
//   DateTime? tgl;
//   String? kodeJasa;
//   String? namaJasa;
//   int? qtyJasa;
//   int? harga;
//
//   Jasa({
//     this.tgl,
//     this.kodeJasa,
//     this.namaJasa,
//     this.qtyJasa,
//     this.harga,
//   });
//
//   factory Jasa.fromJson(Map<String, dynamic> json) => Jasa(
//         tgl: DateTime.parse(json["tgl"]),
//         kodeJasa: json["kode_jasa"],
//         namaJasa: json["nama_jasa"],
//         qtyJasa: json["qty_jasa"],
//         harga: json["harga"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "tgl":
//             "${tgl?.year.toString().padLeft(4, '0')}-${tgl?.month.toString().padLeft(2, '0')}-${tgl?.day.toString().padLeft(2, '0')}",
//         "kode_jasa": kodeJasa,
//         "nama_jasa": namaJasa,
//         "qty_jasa": qtyJasa,
//         "harga": harga,
//       };
// }
//
// class JenisService {
//   int? id;
//   String? namaJenissvc;
//
//   JenisService({
//     this.id,
//     this.namaJenissvc,
//   });
//
//   factory JenisService.fromJson(Map<String, dynamic> json) => JenisService(
//         id: json["id"],
//         namaJenissvc: json["nama_jenissvc"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "nama_jenissvc": namaJenissvc,
//       };
// }
//
// class Cabang {
//   int? id;
//   String? nama;
//   String? alamat;
//   String? telp;
//   dynamic fasilitas;
//   String? jamOperasional;
//   String? latitude;
//   String? longitude;
//   int? idCompany;
//   dynamic keterangan;
//   Company? company;
//
//   Cabang({
//      this.id,
//      this.nama,
//      this.alamat,
//      this.telp,
//      this.fasilitas,
//      this.jamOperasional,
//      this.latitude,
//      this.longitude,
//      this.idCompany,
//      this.keterangan,
//      this.company,
//   });
//
//   factory Cabang.fromJson(Map<String, dynamic> json) => Cabang(
//     id: json["id"],
//     nama: json["nama"],
//     alamat: json["alamat"],
//     telp: json["telp"],
//     fasilitas: json["fasilitas"] != null ? json["fasilitas"] : null,
//     jamOperasional: json["jam_operasional"],
//     latitude: json["latitude"],
//     longitude: json["longitude"],
//     idCompany: json["id_company"],
//     keterangan: json["keterangan"] != null ? json["keterangan"] : null,
//     company: Company.fromJson(json["company"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "nama": nama,
//     "alamat": alamat,
//     "telp": telp,
//     "fasilitas": fasilitas,
//     "jam_operasional": jamOperasional,
//     "latitude": latitude,
//     "longitude": longitude,
//     "id_company": idCompany,
//     "keterangan": keterangan,
//     "company": company?.toJson(),
//   };
// }
//
// class Company {
//   int? id;
//   String? nama;
//
//   Company({
//      this.id,
//      this.nama,
//   });
//
//   factory Company.fromJson(Map<String, dynamic> json) => Company(
//     id: json["id"],
//     nama: json["nama"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "nama": nama,
//   };
// }
//

// To parse this JSON data, do
//
//     final getHistory = getHistoryFromJson(jsonString);
