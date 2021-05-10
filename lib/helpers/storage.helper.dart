import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static Future<void> setStringData(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
    Future.value();
  }

  static Future<void> setJsonData(String key, Map data) async {
    return setStringData(key, jsonEncode(data));
  }

  static Future<void> setBool(String key, bool val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, val);
    Future.value();
  }

  static Future<void> setInt(String key, int val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, val);
    Future.value();
  }

  static Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getBool(key));
  }

  static Future<int> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getInt(key));
  }

  static Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getString(key));
  }

  static Future<Object> getJson(String key) async {
    final data = await getString(key);
    return Future.value(jsonDecode(data));
  }

  static Future<void> clearAll() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    return Future.value();
  }

  static Future<String> get getUserToken async {
    final pref = await SharedPreferences.getInstance();
    final userData = jsonDecode(pref.getString('userData'));
    return Future.value(userData['idToken']);
  }
}
