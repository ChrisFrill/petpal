import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TokenHandler {
// the unique ID of the application
  static const String _applicationId = "my_application_id";

// the storage key for the token
  static const String _storageKeyMobileToken = "token";

// the URL of the Web Server
  static const String _urlBase = "https://www.myserver.com";

// the URI to the Web Server Web API
  static const String _serverApi = "/api/mobile/";

// the mobile device unique identity
  String _deviceIdentity = "";

  /// ----------------------------------------------------------
  /// Method which is only run once to fetch the device identity
  /// ----------------------------------------------------------
  final DeviceInfoPlugin _deviceInfoPlugin = new DeviceInfoPlugin();

  Future<String> _getDeviceIdentity() async {
    if (_deviceIdentity == '') {
      try {
        if (Platform.isAndroid) {
          AndroidDeviceInfo info = await _deviceInfoPlugin.androidInfo;
          _deviceIdentity = "${info.device}-${info.id}";
        } else if (Platform.isIOS) {
          IosDeviceInfo info = await _deviceInfoPlugin.iosInfo;
          _deviceIdentity = "${info.model}-${info.identifierForVendor}";
        }
      } on PlatformException {
        _deviceIdentity = "unknown";
      }
    }
    print(_deviceIdentity);
    return _deviceIdentity;
  }

  /// ----------------------------------------------------------
  /// Method that returns the token from Shared Preferences
  /// ----------------------------------------------------------

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getMobileToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_storageKeyMobileToken) ?? '';
  }

  /// ----------------------------------------------------------
  /// Method that saves the token in Shared Preferences
  /// ----------------------------------------------------------
  Future<bool> setMobileToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(_storageKeyMobileToken, token);
  }

  Future<bool> setUserName(String name) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString("LastUser", name);
  }

  void deleteMobileToken() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(_storageKeyMobileToken);
  }

  Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}
}

