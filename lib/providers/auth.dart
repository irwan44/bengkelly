import 'dart:convert';

import 'package:bengkelly_apps/model/register_model.dart';
import 'package:bengkelly_apps/model/user.dart';
import 'package:bengkelly_apps/utils/box_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/errors.dart';
import '../utils/constants.dart';

abstract class BaseAuth {
  Future<String> register(
    RegisterModel registerModel,
    String noPolice,
    String noHp,
    String idMerk,
    String idType,
    String categoryVehicle,
    String transmisi,
    String years,
    String color,
  );

  Future<String> login(String email, String password);

  Future<UserData> getProfile();

  Future<String> sendOTP(String email);

  Future<String> verifyOTP(String otp);

  Future<String> resetPassword(
    String email,
    String password,
    String confirmPassword,
  );

  Future<String> updateProfile(
    String nama,
    String hp,
    String email,
    String alamat,
    String gambar,
  );

  Future<String> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  );

  Future<void> saveOAuthToken(String accessToken);

  Future<String?> getOAuthData();

  Future<String?> getToken();

  Future<void> signOut();

  Future<void> forceSignOut();
}

class Auth implements BaseAuth {
  @override
  Future<String?> getOAuthData() async {
    var data = await getStorage(APP_OAUTHDATA_KEY);
    return data;
  }

  @override
  Future<String?> getToken() async {
    var data = await getStorage(APP_OAUTHDATA_KEY);
    if (data != null) {
      var token = json.decode(data);
      return token['token'];
    }
    return null;
  }

  @override
  Future<String> login(String email, String password) async {
    var body = {
      'email': email.replaceAll(RegExp(r"\s+\b|\b\s"), ""),
      'password': password.replaceAll(RegExp(r"\s+\b|\b\s"), "")
    };
    debugPrint(json.encode(body));

    var url = LOGIN_ENDPOINT;
    debugPrint("login API POST: $url");

    var client = http.Client();

    final response = await client.post(Uri.parse(url),
        body: json.encode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        });

    client.close();

    if (response.statusCode == 200) {
      saveOAuthToken(response.body);
      return response.body;
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  @override
  Future<void> saveOAuthToken(String oAuthData) async {
    await putStorage(APP_OAUTHDATA_KEY, oAuthData);
  }

  @override
  Future<bool> isLoggedOut() async {
    // Ambil token dari storage
    String? token = await getToken();

    // Jika token tidak null, pengguna dianggap sudah login
    // Jika token null, pengguna dianggap sudah logout
    return token == null;
  }

  @override
  Future<void> forceSignOut() async {
    try {
      await removeStorage(APP_OAUTHDATA_KEY);
    } catch (e) {
      debugPrint(e.toString());

      throw e.toString();
    }
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<String> register(
    RegisterModel registerModel,
    String noPolice,
    String noHp,
    String idMerk,
    String idType,
    String categoryVehicle,
    String transmisi,
    String years,
    String color,
  ) async {
    var body = {
      'nama': registerModel.userName,
      'hp': noHp,
      'email': registerModel.email?.replaceAll(RegExp(r"\s+\b|\b\s"), ""),
      'password': registerModel.password,
      'password_confirmation': registerModel.confirmPassword,
      'no_polisi': noPolice,
      'id_merk': idMerk,
      'id_tipe': idType,
      'kategori_kendaraan': categoryVehicle,
      'transmisi': transmisi,
      'tahun': years,
      'warna': color
    };
    debugPrint(json.encode(body));
    var url = REGISTER_ENDPOINT;
    debugPrint("register API POST: $url");

    var client = http.Client();

    final response = await client.post(Uri.parse(url),
        body: json.encode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        });

    client.close();

    if (response.statusCode == 200) {
      // saveOAuthToken(response.body);
      return response.body;
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  @override
  Future<UserData> getProfile() async {
    var url = GET_PROFILE_ENDPOINT;
    debugPrint('[T] API  getProfile , url GET: $url');
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
      return UserData.fromJson(data);
    } else {
      final data = json.decode(response.body); // Parse error response as JSON
      throw Exception('Error fetching data: ${response.statusCode}, $data');
    }
  }

  @override
  Future<String> updateProfile(
    String? nama,
    String? hp,
    String? email,
    String? alamat,
    String? gambar,
  ) async {
    var url = UPDATE_PROFILE_ENDPOINT;
    debugPrint("updateProfile API POST: $url");

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['nama'] = nama ?? '';
    request.fields['hp'] = hp ?? '';
    request.fields['email'] = email ?? '';
    request.fields['alamat'] = alamat ?? '';

    if (gambar != null && gambar.isNotEmpty) {
      var multipartFile = await http.MultipartFile.fromPath("gambar", gambar);
      request.files.add(multipartFile);
    }

    debugPrint(request.fields.values.toString());
    debugPrint(request.files.toString());
    // add headers to multipart
    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await auth.getToken()}",
    });

    // send
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    debugPrint(response.body.toString());

    if (response.statusCode == 200) {
      return response.body;
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
    // var client = http.Client();
    //
    // final response =
    //     await client.post(Uri.parse(url), body: json.encode(body), headers: {
    //   "Accept": "application/json",
    //   "Content-Type": "application/json",
    //   "Authorization": "Bearer ${await auth.getToken()}"
    // });

    // client.close();

    // if (response.statusCode == 200) {
    //   // saveOAuthToken(response.body);
    //   return response.body;
    // } else {
    //   var error = json.decode(response.body);
    //   throw ErrorModel.fromJson(error).message ?? '';
    // }
  }

  @override
  Future<String> sendOTP(String? email) async {
    var body = {
      'email': email,
    };
    debugPrint(json.encode(body));

    var url = SEND_OTP_ENDPOINT;
    debugPrint("forgot password API POST: $url");
    var client = http.Client();

    final response =
        await client.post(Uri.parse(url), body: json.encode(body), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    client.close();
    if (response.statusCode == 200) {
      return response.body;
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  @override
  Future<String> verifyOTP(String otp) async {
    var body = {
      'otp': otp,
    };
    debugPrint(json.encode(body));

    var url = VERIFY_OTP_ENDPOINT;
    debugPrint("verify otp API POST: $url");
    var client = http.Client();

    final response =
        await client.post(Uri.parse(url), body: json.encode(body), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    client.close();
    if (response.statusCode == 200) {
      return response.body;
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  @override
  Future<String> resetPassword(
    String? email,
    String? password,
    String? confirmPassword,
  ) async {
    // var body = {
    //   'otp': otp,
    // };
    // debugPrint(json.encode(body));

    var url = '$RESET_PASSWORD_ENDPOINT'
        '?password=$password'
        '&password_confirmation=$confirmPassword'
        '&email=$email';
    debugPrint("reset password API POST: $url");
    var client = http.Client();

    final response = await client.post(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    client.close();
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return response.body;
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }

  @override
  Future<String> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    var body = {
      "current_password": currentPassword.replaceAll(RegExp(r"\s+\b|\b\s"), ""),
      "new_password": newPassword.replaceAll(RegExp(r"\s+\b|\b\s"), ""),
      "confirm_password": confirmPassword.replaceAll(RegExp(r"\s+\b|\b\s"), "")
    };
    debugPrint(json.encode(body));

    var url = CHANGE_PASSWORD;
    debugPrint("change pass API POST: $url");

    var client = http.Client();

    final response =
        await client.post(Uri.parse(url), body: json.encode(body), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await auth.getToken()}",
    });

    client.close();

    if (response.statusCode == 200) {
      // saveOAuthToken(response.body);
      return response.body;
    } else {
      var error = json.decode(response.body);
      throw ErrorModel.fromJson(error).message ?? '';
    }
  }
}

final auth = Auth();
