// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:CarTracker/models/activation_model.dart';
import 'package:CarTracker/models/car_photo_model.dart';
import 'package:CarTracker/models/isActive_model.dart';
import 'package:CarTracker/models/login_model.dart';
import 'package:CarTracker/models/passive_model.dart';
import 'package:CarTracker/models/qr_model.dart';
import 'package:CarTracker/models/question_model.dart';
import 'package:CarTracker/models/question_send_model.dart';
import 'package:CarTracker/request/request_services.dart';
import 'package:flutter/material.dart';

class AuthReposityory {
  final RequestService _authService = RequestService();

  Future<LoginModel> toSendLogin(BuildContext context, payload) async {
    dynamic response = await _authService.post(
        context, "/AuthDriver/AuthenticateDriver", payload, false);
    LoginModel loginModel = LoginModel.fromJson(response);

    print(loginModel);
    return loginModel;
  }

  Future<QuestionSendModel> toSendQuestionAndAnswer(
      BuildContext context, payload) async {
    dynamic response = await _authService.post(
        context, "/LocationQuestionHistory/AddQuestionHistory", payload, true);
    QuestionSendModel questionSendModel = QuestionSendModel.fromJson(response);

    print(questionSendModel);
    return questionSendModel;
  }

  Future<IsActiveModel> toSendIsActive(BuildContext context) async {
    dynamic response =
        await _authService.get(context, "/Driver/IsActive", true);
    IsActiveModel isActiveModel = IsActiveModel.fromJson(response);

    print(isActiveModel);
    return isActiveModel;
  }

  Future<CarPhotoModel> toSendCarPhoto(
    BuildContext context,
    payload,
    carId,
    userId,
    startKm,
    startLat,
    startLong,
    frontImg,
    backImg,
    rightImg,
    leftImg,
    startImg,
    insideImg,
  ) async {
    dynamic response = await _authService.postWFile(
        context,
        "/Driver/StartCar?CarId=$carId&UserId=$userId&StartCarKm=$startKm&StartLat=$startLat&StartLong=$startLong&StartCarKmDbPhoto=",
        payload,
        true,
        frontImg,
        backImg,
        rightImg,
        leftImg,
        startImg,
        insideImg);
    CarPhotoModel carPhotoModel = CarPhotoModel.fromJson(response);

    print(carPhotoModel);
    return carPhotoModel;
  }

  Future<CarPhotoModel> toSendCarNoPhoto(
    BuildContext context,
    payload,
    carId,
    userId,
    startKm,
    startLat,
    startLong,
    startImg,
  ) async {
    dynamic response = await _authService.postWNoFile(
      context,
      "/Driver/StartCarNoPhoto?CarId=$carId&UserId=$userId&StartCarKm=$startKm&StartLat=$startLat&StartLong=$startLong&StartCarKmDbPhoto=",
      payload,
      true,
      startImg,
    );
    CarPhotoModel carPhotoModel = CarPhotoModel.fromJson(response);

    print(carPhotoModel);
    return carPhotoModel;
  }

  Future<PassiveModel> toSendEndCarPhoto(
    BuildContext context,
    payload,
    carId,
    userId,
    startKm,
    startLat,
    startLong,
    frontImg,
    backImg,
    rightImg,
    leftImg,
    startImg,
    insideImg,
  ) async {
    dynamic response = await _authService.postWFileEnd(
        context,
        "/Driver/Endcar?Id=$carId&CarId=$carId&UserId=$userId&EndLat=$startLat&EndLong=$startLong&IsUsedEnd=true&EndDate=${DateTime.now()}&IsCanceled=false&EndCarKm=$startKm",
        payload,
        true,
        frontImg,
        backImg,
        rightImg,
        leftImg,
        startImg,
        insideImg);
    PassiveModel passiveModel = PassiveModel.fromJson(response);

    print(passiveModel);
    return passiveModel;
  }

  Future<PassiveModel> toSendEndCarNoPhoto(
    BuildContext context,
    payload,
    carId,
    userId,
    startKm,
    startLat,
    startLong,
    startImg,
  ) async {
    dynamic response = await _authService.postWNoFileEnd(
      context,
      "/Driver/EndCarNoPhoto?Id=$carId&CarId=$carId&UserId=$userId&EndLat=$startLat&EndLong=$startLong&IsUsedEnd=true&EndDate=${DateTime.now()}&IsCanceled=false&EndCarKm=$startKm",
      payload,
      true,
      startImg,
    );
    PassiveModel passiveModel = PassiveModel.fromJson(response);

    print(passiveModel);
    return passiveModel;
  }

  Future<ActivationModel> toSendActivationCode(
      BuildContext context, payload, code) async {
    dynamic response = await _authService.post(
        context, "/AuthDriver/ActiveToken?code=$code", payload, true);
    ActivationModel activationModel = ActivationModel.fromJson(response);

    print(activationModel);
    return activationModel;
  }

  Future<QrModel> toSendQr(BuildContext context, qrId) async {
    dynamic response =
        await _authService.get(context, "/Driver/GetCar?id=$qrId", true);
    QrModel qrModel = QrModel.fromJson(response);

    print(qrModel);
    return qrModel;
  }

  Future<QuestionModel> toGetQuestions(BuildContext context) async {
    dynamic response = await _authService.get(
        context, "/Driver/GetAllQuestionorAnswerDriver", true);
    QuestionModel questionModel = QuestionModel.fromJson(response);

    print(questionModel);
    return questionModel;
  }
}
