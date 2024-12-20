import 'package:flutter/material.dart';

class GlobalVariables {
  static String? userName;
  static String AuthBarrier = "";
  static String? DeviceID = "";
  static String PlayerID = "";
  static String STATUS_LOADING = "loading";
  static String STATUS_SUCCESS = "success";
  static String STATUS_ERROR = "error";
  static String STATUS_NO_INTERNET = "no_internet";
  static String? email;
  static String? tenantCode;
  static String? password;
  static String? activationCode;
  static String? kilometre; 
}

class Utils {
  static void showToastAlert(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
      ),
      duration: const Duration(seconds: 3),
    ));
  }

  static void showAlertDialog(BuildContext context, String msg, onpress) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Hayır",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton(
              onPressed: onpress,
              child: const Text(
                "Evet",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
          title: Text(msg,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
        );
      },
    );
  }
}
