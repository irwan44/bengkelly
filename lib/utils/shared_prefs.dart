import 'package:shared_preferences/shared_preferences.dart';

Future<bool> putId(String key, int? value) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.setInt(key, value!);
}

Future<bool> putMerk(String key, String? value) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.setString(key, value!);
}

Future<String?> getMerkVehicle(String key) async{
  SharedPreferences pref = await SharedPreferences.getInstance();

  return pref.getString(key);
}

Future<int?> getId(String key) async{
  SharedPreferences pref = await SharedPreferences.getInstance();

  return pref.getInt(key);
}

