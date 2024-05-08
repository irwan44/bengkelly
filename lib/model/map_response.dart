class MapResponse {
  List<Candidates>? candidates;
  String? status;

  MapResponse({this.candidates, this.status});

  MapResponse.fromJson(Map<String, dynamic> json) {
    if (json['candidates'] != null) {
      candidates = [];
      json['candidates'].forEach((v) {
        candidates?.add(Candidates.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.candidates != null) {
      data['candidates'] = this.candidates?.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Candidates {
  String? formattedAddress;
  Geometry? geometry;

  Candidates({this.formattedAddress, this.geometry});

  Candidates.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null
        ? Geometry.fromJson(json['geometry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['formatted_address'] = this.formattedAddress;
    if (this.geometry != null) {
      data['geometry'] = this.geometry?.toJson();
    }
    return data;
  }
}

class Geometry {
  MapLocation? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? MapLocation.fromJson(json['location'])
        : null;
    viewport = json['viewport'] != null
        ? Viewport.fromJson(json['viewport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location?.toJson();
    }
    if (this.viewport != null) {
      data['viewport'] = this.viewport?.toJson();
    }
    return data;
  }
}

class MapLocation {
  double? lat;
  double? lng;

  MapLocation({this.lat, this.lng});

  MapLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Viewport {
  MapLocation? northeast;
  MapLocation? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? MapLocation.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? MapLocation.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.northeast != null) {
      data['northeast'] = this.northeast?.toJson();
    }
    if (this.southwest != null) {
      data['southwest'] = this.southwest?.toJson();
    }
    return data;
  }
}
