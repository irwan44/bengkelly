import 'dart:convert';

GetGeneralCheckUp getGeneralCheckUpFromJson(String str) => GetGeneralCheckUp.fromJson(json.decode(str));

String getGeneralCheckUpToJson(GetGeneralCheckUp data) => json.encode(data.toJson());

class GetGeneralCheckUp {
  List<GCU>? data;

  GetGeneralCheckUp({
    this.data,
  });

  factory GetGeneralCheckUp.fromJson(Map<String, dynamic> json) => GetGeneralCheckUp(
    data: List<GCU>.from(json["data"].map((x) => GCU.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
  };
}

class GCU {
  String? subHeading;
  List<String>? gcus;
  List<Map<String, dynamic>>? gcu;

  GCU({
    this.subHeading,
    this.gcus,
    this.gcu,
  });

  factory GCU.fromJson(Map<String, dynamic> json) => GCU(
    subHeading: json["sub_heading"],
    gcus: List<String>.from((json["gcus"] ?? []).map((x) => x.toString())),
    gcu: List<Map<String, dynamic>>.from(json["gcus"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "sub_heading": subHeading,
    "gcus": List<dynamic>.from(gcus?.map((x) => x) ?? []),
    "gcu": List<dynamic>.from(gcu?.map((x) => x) ?? []),
  };
}


