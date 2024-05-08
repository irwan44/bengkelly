import 'dart:convert';
import 'dart:math';

import 'package:bengkelly_apps/model/errors.dart';
import 'package:bengkelly_apps/model/get_history.dart';
import 'package:bengkelly_apps/model/get_lokasi.dart';
import 'package:bengkelly_apps/model/get_vehicle.dart';
import 'package:bengkelly_apps/model/merk_type.dart';
import 'package:bengkelly_apps/model/merk_vehicle.dart';
import 'package:bengkelly_apps/model/nearby_places.dart';
import 'package:bengkelly_apps/model/rss_feed.dart';
import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/utils/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/get_general_checkup.dart';
import '../model/get_service.dart';
import '../model/map_response.dart';
import 'auth.dart';

class Api {
  // ***************************************************
  //
  // API throw Error gunakan json.decode(response.body);
  //
  // ***************************************************
  Future<bool> giveDelay(int millisecond) async {
    // Simulate a future for response after x millisecond.
    return await Future<bool>.delayed(
        Duration(milliseconds: millisecond), () => Random().nextBool());
  }

  Future<MerkVehicle> getMerk() async {
    var url = GET_MERK_ENDPOINT;
    debugPrint('[T] API  getMerk , url GET: $url');
    var client = http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    client.close();

    if (response.statusCode == 200) {
      // print(response.body);
      final data = json.decode(response.body);
      // debugPrint(data);
      return MerkVehicle.fromJson(data);
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  Future<MerkType> getTypeMerk(String idMerk) async {
    var url = '$TYPE_BY_MERK_ENDPOINT/$idMerk';
    debugPrint('[T] API  getTypeMerk , url GET: $url');
    var client = http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    client.close();
    if (response.statusCode == 200) {
      // print(response.body);
      final data = json.decode(response.body);
      // print(data);
      return MerkType.fromJson(data);
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  Future<List<RssFeed>> getNews() async {
    var url = RSS_ENDPOINT;
    print('[T] API  getNews , url GET: $url');
    var client = http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    client.close();

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      // print(data);
      return data.map((rawPost) {
        return RssFeed.fromJson(rawPost);
      }).toList();
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  Future<List<RssFeed>> getNewsFleet() async {
    var url = GET_NEWS_FLEET;
    debugPrint('[T] API  getNewsFleet , url GET: $url');
    var client = http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    client.close();

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      // print(data);
      return data.map((rawPost) {
        return RssFeed.fromJson(rawPost);
      }).toList();
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  Future<List<RssFeed>> getNewsFleed() async {
    var url = GET_NEWS_FLEED;
    debugPrint('[T] API  getNewsFleet , url GET: $url');
    var client = http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    client.close();

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      // print(data);
      return data.map((rawPost) {
        return RssFeed.fromJson(rawPost);
      }).toList();
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  Future<List<RssFeed>> fetchPostsFromSource(
      {required String url, int? perPage, int page = 1}) async {
    final response =
        await http.get(Uri.parse('$url&per_page=$perPage&page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      // print(data);
      return data.map((rawPost) {
        return RssFeed.fromJson(rawPost);
      }).toList();
    } else {
      throw Exception('Failed to load posts: ${response.reasonPhrase}');
    }
  }

  Future<List<RssFeed>> fetchPagingBengkellyNews({int page = 1}) async {
    return fetchPostsFromSource(
        url: RSS_ENDPOINT, perPage: PER_PAGE, page: page);
  }

  Future<List<RssFeed>> fetchPagingFleetNews({int page = 1}) async {
    return fetchPostsFromSource(
        url: GET_NEWS_FLEET, perPage: PER_PAGE, page: page);
  }

  Future<GetLokasi> getLokasi() async {
    var url = GET_LOCATION_ENDPOINT;
    debugPrint('[T] API  getLokasi , url GET: $url');
    var client = http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${await auth.getToken()}"
      },
    );
    client.close();
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GetLokasi.fromJson(data);
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  Future<GetService> getService() async {
    var url = GET_JENIS_SERVICE;
    debugPrint('[T] API  getService , url GET: $url');
    var client = http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${await auth.getToken()}"
      },
    );
    client.close();
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GetService.fromJson(data);
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  Future<GetVehicle> getVehicle() async {
    var url = GET_VEHICLE;
    debugPrint('[T] API  getService , url GET: $url');
    var client = http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${await auth.getToken()}"
      },
    );
    client.close();
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GetVehicle.fromJson(data);
    } else {
      final data = json.decode(response.body); // Parse error response as JSON
      throw Exception('Error fetching data: ${response.statusCode}, $data');
    }
  }

  Future<String> createBooking(
    int? idCab,
    int? idTypeService,
    String? keluhan,
    String? dateBook,
    String? timeBook,
    int? idVehicle,
  ) async {
    var body = {
      'id_cabang': idCab,
      'id_jenissvc': idTypeService,
      'keluhan': keluhan,
      'tgl_booking': dateBook,
      'jam_booking': timeBook,
      'id_kendaraan': idVehicle,
    };
    debugPrint(json.encode(body));

    var url = CREATE_BOOKING;
    debugPrint("create booking API POST: $url");

    var client = http.Client();

    final response =
        await client.post(Uri.parse(url), body: json.encode(body), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await auth.getToken()}"
    });

    client.close();
    if (response.statusCode == 200) {
      return response.body;
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
      // throw json.decode(response.body);
    }
  }

  Future<String> createVehicle(
    String? noPolice,
    int? idMerk,
    int? idTipe,
    String? color,
    String? years,
    String? categoryVehicle,
    String? transmisi,
  ) async {
    var body = {
      'no_polisi': noPolice,
      'id_merk': idMerk,
      'id_tipe': idTipe,
      'warna': color,
      'category_name': categoryVehicle,
      'tahun': years,
      'transmission': transmisi,
    };
    debugPrint(json.encode(body));

    var url = CREATE_VEHICLE;
    debugPrint("create vehicle API POST: $url");
    var client = http.Client();

    final response =
        await client.post(Uri.parse(url), body: json.encode(body), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await auth.getToken()}"
    });

    client.close();
    if (response.statusCode == 200) {
      return response.body;
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  Future<GetHistory> getHistory() async {
    var url = GET_HISTORY_ENDPOINT;
    debugPrint('[T] API  getHistory , url GET: $url');
    var client = http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${await auth.getToken()}"
      },
    );
    client.close();
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GetHistory.fromJson(data);
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  Future<Vehicle?> getMerkVehicles() async {
    return await getVehiclesMerk();
  }

  Future<Vehicle?> getVehiclesMerk() async {
    var vehicle = await getMerkVehicle(VEHICLE);
    return Vehicle.fromJson(json.decode(vehicle!));
  }

  Future<GetGeneralCheckUp> getGCU() async {
    var url = GENERAL_CHECK_UP;
    debugPrint('[T] API  getGCU , url GET: $url');
    var client = http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${await auth.getToken()}"
      },
    );
    client.close();
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GetGeneralCheckUp.fromJson(data);
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  Future<GetNearbyPlaces> getNearbyPlaces(
    String latitude,
    String longitude,
    String radius,
  ) async {
    var url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=$latitude,$longitude'
        '&radius=$radius'
        '&key=$GOOGLE_API_KEY';
    debugPrint(url);
    var client = http.Client();
    var response = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });
    client.close();
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return GetNearbyPlaces.fromJson(data);
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  Future<MapResponse> placesApi({String? cari}) async {
    var url =
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cgeometry&input=$cari&inputtype=textquery&key=$GOOGLE_API_KEY";

    debugPrint('[API] placesApi, GET: $url');

    var client = new http.Client();

    final response = await client.get(Uri.parse(url));
    client.close();

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return MapResponse.fromJson(data);
    }
    throw json.decode(response.body);
  }

  Future<String> createEmergency(
    int? idCab,
    String? keluhan,
    int? idVehicle,
  ) async {
    var body = {
      'id_cabang': idCab,
      'keluhan': keluhan,
      'id_kendaraan': idVehicle,
    };
    debugPrint(json.encode(body));

    var url = CREATE_EMERGENCY;
    debugPrint("create emergency API POST: $url");

    var client = http.Client();

    final response =
        await client.post(Uri.parse(url), body: json.encode(body), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await auth.getToken()}"
    });

    client.close();
    if (response.statusCode == 200) {
      return response.body;
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
      // throw json.decode(response.body);
    }
  }
}

final api = Api();
