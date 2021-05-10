import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import '../helpers/storage.helper.dart';
import '../config/http.config.dart';

class AuthProvider with ChangeNotifier {
  String idToken = '';
  DateTime exipryAt;
  Timer _timer;

  bool get isLoggedIn {
    return (exipryAt != null &&
        exipryAt.isAfter(DateTime.now()) &&
        idToken != '');
  }

  Future<void> signup(String email, String password) async {
    try {
      final url = Uri.parse('$SIGNUP_URL');
      print(url);
      final body = jsonEncode(
          {'email': email, 'password': password, 'returnSecureToken': true});
      http.Response response = await http.post(url, body: body);
      print(response.body);
      Future.value();
    } catch (err) {
      throw err;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password); // this is used for accessing storage plugin
      final url = Uri.parse('$LOGIN_URL');
      final body = jsonEncode(
          {'email': email, 'password': password, 'returnSecureToken': true});
      http.Response response = await http.post(url, body: body);
      final decodedBody = jsonDecode(response.body);
      final hasError = decodedBody['error'];
      if (hasError != null) {
        throw new Exception('Invalid password or password');
      }
      idToken = decodedBody['idToken'];

      
      final int  parsedTime = int.parse(decodedBody['expiresIn']);
      exipryAt = DateTime.now()
          .add(Duration(seconds: int.parse(decodedBody['expiresIn'])));
      await StorageHelper.setStringData('userData', response.body);
      final dateString = DateTime.now()
          .add(Duration(seconds: int.parse(decodedBody['expiresIn'])));
      await StorageHelper.setStringData(
          'loggedInAt', dateString.toIso8601String());
      notifyListeners();
      _autoLogout(parsedTime);
      Future.value();
    } catch (err) {
      throw err;
    }
  }

  void logout() async {
    await StorageHelper.clearAll();
    exipryAt = null;
    idToken = '';
    notifyListeners();
  }

  void _autoLogout(int seconds) {
    if (_timer != null) {
      _timer.cancel();
    }
    Timer(Duration(seconds: seconds), () {
      logout();
    });
  }

  Future<bool> tryAutoLogin() async {
    try {
      final userData = await StorageHelper.getString('userData');
      final loggedInAtTime = await StorageHelper.getString('loggedInAt');
      final DateTime parsedDate = DateTime.parse(loggedInAtTime);
      final decodedBody = jsonDecode(userData);
      if (userData == null ||
          loggedInAtTime == null 
          || decodedBody['idToken'] == null
          || (loggedInAtTime != null &&
              DateTime.now().isAfter(parsedDate))) {
        return Future.value(false);
      }
      idToken = decodedBody['idToken'];
      exipryAt = parsedDate;
      final int loggedOutSecDiff = parsedDate.difference(DateTime.now()).inSeconds.toInt();
      _autoLogout(loggedOutSecDiff);
      notifyListeners();
      return Future.value(true);
    } catch (err) {
      return Future.value(false);
    }
  }
}
