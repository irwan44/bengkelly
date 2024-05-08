import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

IOSOptions _getIOSOptions() => const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    );

Future<String?> getStorage(String key) async {
  FlutterSecureStorage prefs = FlutterSecureStorage(
      aOptions: _getAndroidOptions(), iOptions: _getIOSOptions());
  return prefs.read(
      key: key, aOptions: _getAndroidOptions(), iOptions: _getIOSOptions());
}

Future<void> putStorage(String key, String value) async {
  FlutterSecureStorage prefs = FlutterSecureStorage(
      aOptions: _getAndroidOptions(), iOptions: _getIOSOptions());
  return prefs.write(
      key: key,
      value: value,
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions());
}

Future<void> removeStorage(String key) async {
  FlutterSecureStorage prefs =
      FlutterSecureStorage(aOptions: _getAndroidOptions());
  return prefs.delete(
      key: key, aOptions: _getAndroidOptions(), iOptions: _getIOSOptions());
}

Future<void> clearStorage() async {
  FlutterSecureStorage prefs = FlutterSecureStorage(
      aOptions: _getAndroidOptions(), iOptions: _getIOSOptions());
  return prefs.deleteAll(
      aOptions: _getAndroidOptions(), iOptions: _getIOSOptions());
}
