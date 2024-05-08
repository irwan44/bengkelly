// To parse this JSON data, do
//
//     final getLokasi = getLokasiFromJson(jsonString);

import 'dart:convert';

GetLokasi getLokasiFromJson(String str) => GetLokasi.fromJson(json.decode(str));

String getLokasiToJson(GetLokasi data) => json.encode(data.toJson());

class GetLokasi {
  bool? status;
  String? message;
  List<Lokasi>? data;

  GetLokasi({
    this.status,
    this.message,
    this.data,
  });

  factory GetLokasi.fromJson(Map<String, dynamic> json) => GetLokasi(
        status: json["status"],
        message: json["message"],
        data: List<Lokasi>.from(json["data"].map((x) => Lokasi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
      };
}

class Lokasi {
  String? name;
  Geometry? geometry;
  String? vicinity;
  String? wa;

  Lokasi({
    this.name,
    this.geometry,
    this.vicinity,
    this.wa,
  });

  factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
        name: json["name"],
        geometry: Geometry.fromJson(json["geometry"]),
        vicinity: json["vicinity"],
        wa: json["wa"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "geometry": geometry?.toJson(),
        "vicinity": vicinity,
        "wa": wa,
      };
}

class Geometry {
  Location? location;

  Geometry({
    required this.location,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
      };
}

class Location {
  String? lat;
  String? lng;
  int? id;

  Location({
    this.lat,
    this.lng,
    this.id,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"],
        lng: json["lng"],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "id": id,
      };
}
