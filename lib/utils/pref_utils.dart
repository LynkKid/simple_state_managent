//ignore: unused_import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    // init();
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  SharedPreferences? sharedPreferences() {
    return _sharedPreferences;
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    debugPrint('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  void removeKey(String key) async {
    _sharedPreferences!.remove(key);
  }

  Future<void> setString(String key, String value) {
    return _sharedPreferences!.setString(key, value);
  }

  String? getString(String key) {
    try {
      return _sharedPreferences!.getString(key)!;
    } catch (e) {
      return null;
    }
  }

  Future<void> setStringList(String key, List<String> value) {
    return _sharedPreferences!.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    try {
      return _sharedPreferences!.getStringList(key)!;
    } catch (e) {
      return null;
    }
  }

  Future<void> setBool(String key, bool value) {
    return _sharedPreferences!.setBool(key, value);
  }

  bool? getBool(String key) {
    try {
      return _sharedPreferences!.getBool(key)!;
    } catch (e) {
      return null;
    }
  }

  Future<void> setDouble(String key, double value) {
    return _sharedPreferences!.setDouble(key, value);
  }

  double? getDouble(String key) {
    try {
      return _sharedPreferences!.getDouble(key)!;
    } catch (e) {
      return null;
    }
  }

  Future<void> setInt(String key, int value) {
    return _sharedPreferences!.setInt(key, value);
  }

  int? getInt(String key) {
    try {
      return _sharedPreferences!.getInt(key)!;
    } catch (e) {
      return null;
    }
  }

  Future<void> setIdGetToFirebase(String value) {
    return _sharedPreferences!.setString('ID_DATA_FIREBASE', value);
  }

  String? getIdGetToFirebase() {
    try {
      return _sharedPreferences!.getString('ID_DATA_FIREBASE')!;
    } catch (e) {
      return null;
    }
  }
}
