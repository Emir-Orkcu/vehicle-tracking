// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:CarTracker/function/function.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RequestService {
  Future<dynamic> get(BuildContext context, loginPath, isToken) async {
    dynamic responseJson;
    try {
      Response? response = await getRequest(loginPath, context, isToken);
      responseJson = returnResponse(response!, context);
    } on SocketException {
      print('No Internete Connection');
    }
    return responseJson;
  }

  Future<dynamic> post(
      BuildContext context, loginPath, payload, isToken) async {
    dynamic responseJson;
    try {
      Response? response =
          await SendRequest(loginPath, isToken, payload, context);
      responseJson = returnResponse(response!, context);
    } on SocketException {
      print('No Internete Connection');
    }
    return responseJson;
  }

  Future<dynamic> postWFile(
    BuildContext context,
    loginPath,
    payload,
    isToken,
    frontImg,
    backImg,
    rightImg,
    leftImg,
    startImg,
    insideImg,
  ) async {
    dynamic responseJson;
    try {
      var response = await SendRequestWithFile(
        loginPath,
        isToken,
        payload,
        frontImg,
        backImg,
        rightImg,
        leftImg,
        startImg,
        context,
        insideImg,
      );
      responseJson = returnResponse(response!, context);
    } on SocketException {
      print('No Internete Connection');
    }
    return responseJson;
  }

  Future<dynamic> postWNoFile(
    BuildContext context,
    loginPath,
    payload,
    isToken,
    startImg,
  ) async {
    dynamic responseJson;
    try {
      var response = await SendRequestWithNoFile(
        loginPath,
        isToken,
        payload,
        startImg,
        context,
      );
      responseJson = returnResponse(response!, context);
    } on SocketException {
      print('No Internete Connection');
    }
    return responseJson;
  }

  Future<dynamic> postWNoFileEnd(
    BuildContext context,
    loginPath,
    payload,
    isToken,
    startImg,
  ) async {
    dynamic responseJson;
    try {
      var response = await SendRequestWithNoFileEnd(
        loginPath,
        isToken,
        payload,
        startImg,
        context,
      );
      responseJson = returnResponse(response!, context);
    } on SocketException {
      print('No Internete Connection');
    }
    return responseJson;
  }

  Future<dynamic> postWFileEnd(
    BuildContext context,
    loginPath,
    payload,
    isToken,
    frontImg,
    backImg,
    rightImg,
    leftImg,
    startImg,
    insideImg,
  ) async {
    dynamic responseJson;
    try {
      var response = await SendRequestWithFileEnd(
        loginPath,
        isToken,
        payload,
        frontImg,
        backImg,
        rightImg,
        leftImg,
        startImg,
        context,
        insideImg,
      );
      responseJson = returnResponse(response!, context);
    } on SocketException {
      print('No Internete Connection');
    }
    return responseJson;
  }
}
