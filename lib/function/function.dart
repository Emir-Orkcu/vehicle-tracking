// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:CarTracker/constants/constants.dart';
import 'package:CarTracker/global_variables.dart';
import 'package:CarTracker/models/file_model.dart';
import 'package:CarTracker/screens/onboarding/main_sign_screen.dart';
import 'package:CarTracker/sharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future SendRequest(
  String path,
  bool isToken,
  var payload,
  context,
) async {
  try {
    Map<String, String> my_header = {};

    Uri uri = Uri.parse(Constants.API_URL + path);
    if (isToken) {
      String? token = await Preferences().getToken();
      my_header = {
        "Auth": token,
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      };
    } else {
      my_header = {'accept': '*/*', 'Content-Type': 'application/json'};
    }

    var response =
        await http.post(uri, headers: my_header, body: jsonEncode(payload));
    print(uri);

    return response;
  } catch (e) {
    Utils.showToastAlert(context, e.toString());
    return null;
  }
}

Future getRequest(path, context, isToken) async {
  var url = Uri.parse(Constants.API_URL + path);
  Map<String, String> my_header = {};
  if (isToken) {
    String? token = await Preferences().getToken();
    my_header = {
      "Auth": token,
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
  } else {
    my_header = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
  }

  try {
    var response = await http.get(url, headers: my_header);
    print(response);
    return response;
  } catch (e) {
    Utils.showToastAlert(context, 'GET isteği sırasında bir hata oluştu: $e');
    print('GET isteği sırasında bir hata oluştu: $e');
    return null;
  }
}

dynamic returnResponse(http.Response response, context) {
  print(response.statusCode);
  print(response.body);
  switch (jsonDecode(response.body)["code"]) {
    case 200 || 0:
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;

    case 404:
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Kapat",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
            title: Text(jsonDecode(response.body)["message"] ?? "null",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          );
        },
      );
    case 500:
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Kapat",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
            title: const Text("Internal Server Error",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          );
        },
      );

    default:
      if (response.statusCode == 401) {
        showDialog<void>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.grey,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainSignScreen(),
                        ));
                  },
                  child: const Text(
                    "Tamam",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
              title: const Text("Uygulamaya Tekrar Giriş Yapın.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            );
          },
        );
      } else {
        return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.grey,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Kapat",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
              title: Text(jsonDecode(response.body)["message"] ?? "null",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            );
          },
        );
      }
  }
}

Future SendRequestWithFile(
  String path,
  bool isToken,
  Map<String, dynamic> payload,
  List<FileModel>? frontImg,
  List<FileModel>? backImg,
  List<FileModel>? rightImg,
  List<FileModel>? leftImg,
  List<FileModel>? startImg,
  context,
  List<FileModel>? insideImg,
) async {
  try {
    http.MultipartRequest m_request;
    http.Request request;
    Map<String, String> my_header = {};

    Uri uri = Uri.parse(Constants.API_URL + path);
    if (isToken) {
      String? token = await Preferences().getToken();
      my_header = {
        "Auth": token,
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      };
    } else {
      my_header = {'accept': '*/*', 'Content-Type': 'application/json'};
    }
    m_request = http.MultipartRequest("POST", uri);

    File fileStartKm = File(startImg![0].devicePath!);
    File fileFront = File(frontImg![0].devicePath!);
    File fileBack = File(backImg![0].devicePath!);
    File fileLeft = File(leftImg![0].devicePath!);
    File fileRight = File(rightImg![0].devicePath!);
    File fileInside = File(insideImg![0].devicePath!);

    m_request.files.add(
        await http.MultipartFile.fromPath('StartKmPhoto', fileStartKm.path));
    m_request.files
        .add(await http.MultipartFile.fromPath('FrontImg', fileFront.path));
    m_request.files
        .add(await http.MultipartFile.fromPath('BackImg', fileBack.path));
    m_request.files
        .add(await http.MultipartFile.fromPath('LeftImg', fileLeft.path));
    m_request.files
        .add(await http.MultipartFile.fromPath('RightImg', fileRight.path));
    m_request.files
        .add(await http.MultipartFile.fromPath('InsideImg', fileInside.path));

    var newPayload =
        payload.map((key, value) => MapEntry(key, value.toString()));
    m_request.fields.addAll(newPayload);
    m_request.headers.addAll(my_header);
    var response = await m_request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseData);
    print(responseString);
    print(m_request);
    return http.Response.bytes(responseData, response.statusCode);
  } catch (error) {
    print(error);

    return null;
  }
}

Future SendRequestWithFileEnd(
  String path,
  bool isToken,
  Map<String, dynamic> payload,
  List<FileModel>? frontImg,
  List<FileModel>? backImg,
  List<FileModel>? rightImg,
  List<FileModel>? leftImg,
  List<FileModel>? startImg,
  context,
  List<FileModel>? insideImg,
) async {
  try {
    http.MultipartRequest m_request;
    http.Request request;
    Map<String, String> my_header = {};

    Uri uri = Uri.parse(Constants.API_URL + path);
    if (isToken) {
      String? token = await Preferences().getToken();
      my_header = {
        "Auth": token,
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      };
    } else {
      my_header = {'accept': '*/*', 'Content-Type': 'application/json'};
    }
    m_request = http.MultipartRequest("POST", uri);

    File fileStartKm = File(startImg![0].devicePath!);
    File fileFront = File(frontImg![0].devicePath!);
    File fileBack = File(backImg![0].devicePath!);
    File fileLeft = File(leftImg![0].devicePath!);
    File fileRight = File(rightImg![0].devicePath!);
    File fileInside = File(insideImg![0].devicePath!);

    m_request.files
        .add(await http.MultipartFile.fromPath('EndKMPhoto', fileStartKm.path));
    m_request.files
        .add(await http.MultipartFile.fromPath('FrontImg', fileFront.path));
    m_request.files
        .add(await http.MultipartFile.fromPath('BackImg', fileBack.path));
    m_request.files
        .add(await http.MultipartFile.fromPath('LeftImg', fileLeft.path));
    m_request.files
        .add(await http.MultipartFile.fromPath('RightImg', fileRight.path));
    m_request.files
        .add(await http.MultipartFile.fromPath('InsideImg', fileInside.path));

    var newPayload =
        payload.map((key, value) => MapEntry(key, value.toString()));
    m_request.fields.addAll(newPayload);
    m_request.headers.addAll(my_header);
    var response = await m_request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseData);
    print(responseString);
    print(m_request);
    return http.Response.bytes(responseData, response.statusCode);
  } catch (error) {
    print(error);

    return null;
  }
}

Future SendRequestWithNoFileEnd(
  String path,
  bool isToken,
  Map<String, dynamic> payload,
  List<FileModel>? startImg,
  context,
) async {
  try {
    http.MultipartRequest m_request;
    http.Request request;
    Map<String, String> my_header = {};

    Uri uri = Uri.parse(Constants.API_URL + path);
    if (isToken) {
      String? token = await Preferences().getToken();
      my_header = {
        "Auth": token,
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      };
    } else {
      my_header = {'accept': '*/*', 'Content-Type': 'application/json'};
    }
    m_request = http.MultipartRequest("POST", uri);

    File fileStartKm = File(startImg![0].devicePath!);

    m_request.files
        .add(await http.MultipartFile.fromPath('EndKMPhoto', fileStartKm.path));

    var newPayload =
        payload.map((key, value) => MapEntry(key, value.toString()));
    m_request.fields.addAll(newPayload);
    m_request.headers.addAll(my_header);
    var response = await m_request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseData);
    print(responseString);
    print(m_request);
    return http.Response.bytes(responseData, response.statusCode);
  } catch (error) {
    print(error);

    return null;
  }
}

Future SendRequestWithNoFile(
  String path,
  bool isToken,
  Map<String, dynamic> payload,
  List<FileModel>? startImg,
  context,
) async {
  try {
    http.MultipartRequest m_request;
    http.Request request;
    Map<String, String> my_header = {};

    Uri uri = Uri.parse(Constants.API_URL + path);
    if (isToken) {
      String? token = await Preferences().getToken();
      my_header = {
        "Auth": token,
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      };
    } else {
      my_header = {'accept': '*/*', 'Content-Type': 'application/json'};
    }
    m_request = http.MultipartRequest("POST", uri);

    File fileStartKm = File(startImg![0].devicePath!);

    m_request.files.add(
        await http.MultipartFile.fromPath('StartKmPhoto', fileStartKm.path));

    var newPayload =
        payload.map((key, value) => MapEntry(key, value.toString()));
    m_request.fields.addAll(newPayload);
    m_request.headers.addAll(my_header);
    var response = await m_request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseData);
    print(responseString);
    print(m_request);
    return http.Response.bytes(responseData, response.statusCode);
  } catch (error) {
    print(error);

    return null;
  }
}
