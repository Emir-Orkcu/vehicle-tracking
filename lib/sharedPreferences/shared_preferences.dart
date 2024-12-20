import 'package:CarTracker/screens/mainScreen/main_screen.dart';
import 'package:CarTracker/screens/onboarding/main_sign_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future<Widget> authControll(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("auto")) {
      return const MainScreen();
    } else {
      return const MainSignScreen();
    }
  }

  void qrIdAdd(String response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("qrId", response);
  }

  void qrIdDelete() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("qrId");
  }

  Future<String> getQrId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("qrId").toString();
  }

  void autoLogInAdd(String response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("auto", response);
  }

  void autoLogInDelete() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("auto");
  }

  void tokenDelete() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }

  void tenantDelete() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("tenant");
  }

  void tokenAdd(String response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", response);
  }

  void tenantIdAdd(String response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("tenant", response);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("token").toString();
  }

  Future<String> getTenant() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("tenant").toString();
  }

  void phoneNumberAdd(response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("phone", response);
  }

  void passwordAdd(response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("password", response);
  }

  void phoneNumberDelete() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("phone");
  }

  void passwordDelete() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("password");
  }

  void rememberMeAdd(response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("remember", response);
  }

  void rememberDelete() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("remember");
  }

  Future getRemember() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("remember");
  }

  Future<String> getPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("phone").toString();
  }

  Future<String> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("password").toString();
  }

  void languageAdd(response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language", response);
  }

  Future<String> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("language").toString();
  }
}
