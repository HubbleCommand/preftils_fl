library preftils;

import 'package:shared_preferences/shared_preferences.dart';

class CodableException implements Exception {
  String error;
  CodableException(this.error);
}

abstract class Codable {
  String encode();
  Codable decode(String data);
}

class Preference<T/* extends Object*/>{
  final String key;
  final T defaultValue;

  Preference(this.key, this.defaultValue);

  /// Synchronously retrieve the current value of the preference, passing an instance of SharedPreferences is required
  /// Can throw a CodableException if decoding fails
  T getSync(SharedPreferences prefs, {T? defaultValue}) {
    switch (this.defaultValue) {
      case int _: return prefs.getInt(key) as T? ?? defaultValue ?? this.defaultValue;
      case bool _: return prefs.getBool(key) as T? ?? defaultValue ?? this.defaultValue;
      case double _: return prefs.getDouble(key) as T? ?? defaultValue ?? this.defaultValue;
      case String _: return prefs.getString(key) as T? ?? defaultValue ?? this.defaultValue;
      case List<String> _: return prefs.getStringList(key) as T? ?? defaultValue ?? this.defaultValue;
      case Codable codable:
        String? pref = prefs.getString(key);
        if (pref == null) {
          break;
        }

        try {
          return codable.decode(pref) as T;
        } finally {
          throw CodableException("Failed to decode");
        }
    }
    return defaultValue ?? this.defaultValue;
  }

  /// Retrieve the current value of the preference, optionally pass an instance of SharedPreferences to speed things up
  Future<T> get({T? defaultValue, SharedPreferences? prefs}) async {
    SharedPreferences p = prefs ?? await SharedPreferences.getInstance();
    return getSync(p);
  }

  /// Set the value of the preference, optionally pass an instance of SharedPreferences to speed things up
  Future<bool> set(T value, {SharedPreferences? prefs}) async {
    SharedPreferences p = prefs ?? await SharedPreferences.getInstance();
    switch (defaultValue) {
      case int _:
        return p.setInt(key, value as int);
      case bool _:
        return p.setBool(key, value as bool);
      case double _:
        return p.setDouble(key, value as double);
      case String _:
        return p.setString(key, value as String);
      case const (List<String>) :
        return p.setStringList(key, value as List<String>);
      case Codable codable:
        return p.setString(key, codable.encode());
      default:
        return Future.value(false);
    }
  }
}
