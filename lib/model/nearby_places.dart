// To parse this JSON data, do
//
//     final getNearbyPlaces = getNearbyPlacesFromJson(jsonString);

import 'dart:convert';

GetNearbyPlaces getNearbyPlacesFromJson(String str) => GetNearbyPlaces.fromJson(json.decode(str));

String getNearbyPlacesToJson(GetNearbyPlaces data) => json.encode(data.toJson());

class GetNearbyPlaces {
  List<dynamic>? htmlAttributions;
  String? nextPageToken;
  List<Result>? results;
  String? status;

  GetNearbyPlaces({
     this.htmlAttributions,
     this.nextPageToken,
     this.results,
     this.status,
  });

  factory GetNearbyPlaces.fromJson(Map<String, dynamic> json) => GetNearbyPlaces(
    htmlAttributions: List<dynamic>.from(json["html_attributions"].map((x) => x)),
    nextPageToken: json["next_page_token"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "html_attributions": List<dynamic>.from(htmlAttributions?.map((x) => x) ?? []),
    "next_page_token": nextPageToken,
    "results": List<dynamic>.from(results?.map((x) => x.toJson()) ?? []),
    "status": status,
  };
}

class Result {
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  List<Photo>? photos;
  String? placeId;
  String? reference;
  String? scope;
  List<String>? types;
  String? vicinity;
  String? businessStatus;
  OpeningHours? openingHours;
  PlusCode? plusCode;
  double? rating;
  int? userRatingsTotal;
  bool? permanentlyClosed;

  Result({
     this.geometry,
     this.icon,
     this.iconBackgroundColor,
     this.iconMaskBaseUri,
     this.name,
    this.photos,
     this.placeId,
     this.reference,
     this.scope,
     this.types,
     this.vicinity,
    this.businessStatus,
    this.openingHours,
    this.plusCode,
    this.rating,
    this.userRatingsTotal,
    this.permanentlyClosed,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    geometry: Geometry.fromJson(json["geometry"]),
    icon: json["icon"],
    iconBackgroundColor: json["icon_background_color"],
    iconMaskBaseUri: json["icon_mask_base_uri"],
    name: json["name"],
    photos: json["photos"] == null ? [] : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
    placeId: json["place_id"],
    reference: json["reference"],
    scope: json["scope"],
    types: List<String>.from(json["types"].map((x) => x)),
    vicinity: json["vicinity"],
    businessStatus: json["business_status"],
    openingHours: json["opening_hours"] == null ? null : OpeningHours.fromJson(json["opening_hours"]),
    plusCode: json["plus_code"] == null ? null : PlusCode.fromJson(json["plus_code"]),
    rating: json["rating"]?.toDouble(),
    userRatingsTotal: json["user_ratings_total"],
    permanentlyClosed: json["permanently_closed"],
  );

  Map<String, dynamic> toJson() => {
    "geometry": geometry?.toJson(),
    "icon": icon,
    "icon_background_color": iconBackgroundColor,
    "icon_mask_base_uri": iconMaskBaseUri,
    "name": name,
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x.toJson())),
    "place_id": placeId,
    "reference": reference,
    "scope": scope,
    "types": List<dynamic>.from(types?.map((x) => x) ?? []),
    "vicinity": vicinity,
    "business_status": businessStatus,
    "opening_hours": openingHours?.toJson(),
    "plus_code": plusCode?.toJson(),
    "rating": rating,
    "user_ratings_total": userRatingsTotal,
    "permanently_closed": permanentlyClosed,
  };
}

class Geometry {
  Location location;
  Viewport viewport;

  Geometry({
    required this.location,
    required this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: Location.fromJson(json["location"]),
    viewport: Viewport.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "viewport": viewport.toJson(),
  };
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Viewport {
  Location northeast;
  Location southwest;

  Viewport({
    required this.northeast,
    required this.southwest,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
    northeast: Location.fromJson(json["northeast"]),
    southwest: Location.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast.toJson(),
    "southwest": southwest.toJson(),
  };
}

class OpeningHours {
  bool openNow;

  OpeningHours({
    required this.openNow,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
    openNow: json["open_now"],
  );

  Map<String, dynamic> toJson() => {
    "open_now": openNow,
  };
}

class Photo {
  int height;
  List<String> htmlAttributions;
  String photoReference;
  int width;

  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    height: json["height"],
    htmlAttributions: List<String>.from(json["html_attributions"].map((x) => x)),
    photoReference: json["photo_reference"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
    "photo_reference": photoReference,
    "width": width,
  };
}

class PlusCode {
  String compoundCode;
  String globalCode;

  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
    compoundCode: json["compound_code"],
    globalCode: json["global_code"],
  );

  Map<String, dynamic> toJson() => {
    "compound_code": compoundCode,
    "global_code": globalCode,
  };
}
