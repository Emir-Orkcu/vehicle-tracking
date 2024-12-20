// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:CarTracker/auth/auth_repo.dart';
import 'package:CarTracker/constants/constants.dart';
import 'package:CarTracker/models/activation_model.dart';
import 'package:CarTracker/models/car_photo_model.dart';
import 'package:CarTracker/models/isActive_model.dart';
import 'package:CarTracker/models/login_model.dart';
import 'package:CarTracker/models/passive_model.dart';
import 'package:CarTracker/models/qr_model.dart';
import 'package:CarTracker/models/question_model.dart';
import 'package:CarTracker/models/question_send_model.dart';
import 'package:CarTracker/screens/activatedScreen/activated_screen.dart';
import 'package:CarTracker/screens/carInformations/car_Information_screen.dart';
import 'package:CarTracker/screens/carKmPhoto/car_km_photo_screen.dart';
import 'package:CarTracker/screens/carPhotosScreen/car_photo_screen.dart';
import 'package:CarTracker/screens/onboarding/main_sign_screen.dart';
import 'package:CarTracker/screens/passiveScreen/passivated_screen.dart';
import 'package:CarTracker/screens/permissionScreen/permission_screen.dart';
import 'package:CarTracker/screens/questionScreen/question_screen.dart';
import 'package:CarTracker/sharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stepper_a/stepper_a.dart';

class SendViewModel with ChangeNotifier {
  LoginModel? _loginModel;
  LoginModel get loginModel {
    return _loginModel!;
  }

  ActivationModel? _activationModel;
  ActivationModel get activationModel {
    return _activationModel!;
  }

  CarPhotoModel? _carPhotoModel;
  CarPhotoModel get carPhotoModel {
    return _carPhotoModel!;
  }

  PassiveModel? _passiveModel;
  PassiveModel get passiveModel {
    return _passiveModel!;
  }

  double? _lat;
  double get lat {
    return _lat!;
  }

  double? _long;
  double get long {
    return _long!;
  }

  QrModel? _qrModel;
  QrModel get qrModel {
    return _qrModel!;
  }

  IsActiveModel? _isActive;
  IsActiveModel get isActive {
    return _isActive!;
  }

  QuestionModel? _questionModel;
  QuestionModel get questionModel {
    return _questionModel!;
  }

  QuestionSendModel? _questionSendModel;
  QuestionSendModel get questionSendModel {
    return _questionSendModel!;
  }

  Future<void> sendLogin(context, payload, controller) async {
    try {
      currentStatus = ApiResponseStatus.loading;
      notifyListeners();

      _loginModel = await AuthReposityory().toSendLogin(context, payload);
      Preferences().tokenAdd(_loginModel!.data!.auth!.token!);
      currentStatus = ApiResponseStatus.succesfull;
    } catch (e) {
      currentStatus = ApiResponseStatus.error;
      controller?.back(
        onTap: (currentIndex) {},
      );
    }
    currentStatus = ApiResponseStatus.noDefinations;
    notifyListeners();
  }

  Future<void> sendIsActive(context) async {
    try {
      currentStatus = ApiResponseStatus.loading;

      _isActive = await AuthReposityory().toSendIsActive(context);
      currentStatus = ApiResponseStatus.succesfull;
    } catch (e) {
      currentStatus = ApiResponseStatus.error;
    }
    currentStatus = ApiResponseStatus.noDefinations;
    notifyListeners();
  }

  Future<void> sendQuestion(context, payload) async {
    try {
      currentStatus = ApiResponseStatus.loading;

      _questionSendModel =
          await AuthReposityory().toSendQuestionAndAnswer(context, payload);
      currentStatus = ApiResponseStatus.succesfull;
     Navigator.push(context,  MaterialPageRoute(
        builder: (context) => const ActivatedScreen(),
      ));
    } catch (e) {
      currentStatus = ApiResponseStatus.error;
    }
    currentStatus = ApiResponseStatus.noDefinations;
    notifyListeners();
  }

  Future<void> sendCarPhoto(
    context,
    payload,
    files,
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
    try {
      currentStatus = ApiResponseStatus.loading;
      notifyListeners();

      _carPhotoModel = await AuthReposityory().toSendCarPhoto(
        context,
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
      );
      currentStatus = ApiResponseStatus.succesfull;
      Preferences().autoLogInAdd(_loginModel!.data!.auth!.token!);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QuestionScreen(),
          ));
    } catch (e) {
      currentStatus = ApiResponseStatus.error;
    }
    currentStatus = ApiResponseStatus.noDefinations;
    notifyListeners();
  }

  Future<void> sendCarNoPhoto(
    context,
    payload,
    files,
    carId,
    userId,
    startKm,
    startLat,
    startLong,
    startImg,
  ) async {
    try {
      currentStatus = ApiResponseStatus.loading;
      notifyListeners();

      _carPhotoModel = await AuthReposityory().toSendCarNoPhoto(context,
          payload, carId, userId, startKm, startLat, startLong, startImg);
      currentStatus = ApiResponseStatus.succesfull;
      Preferences().autoLogInAdd(_loginModel!.data!.auth!.token!);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ActivatedScreen(),
          ));
    } catch (e) {
      currentStatus = ApiResponseStatus.error;
    }
    currentStatus = ApiResponseStatus.noDefinations;
    notifyListeners();
  }

  Future<void> sendEndCarPhoto(
    context,
    payload,
    files,
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
    try {
      currentStatus = ApiResponseStatus.loading;
      notifyListeners();

      _passiveModel = await AuthReposityory().toSendEndCarPhoto(
        context,
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
      );
      currentStatus = ApiResponseStatus.succesfull;
      Preferences().tokenDelete();
      Preferences().autoLogInDelete();
      Preferences().qrIdDelete();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const PassivatedScreen(),
        ),
      );
    } catch (e) {
      currentStatus = ApiResponseStatus.error;
    }
    currentStatus = ApiResponseStatus.noDefinations;
    notifyListeners();
  }

  Future<void> sendEndCarNoPhoto(
    context,
    payload,
    files,
    carId,
    userId,
    startKm,
    startLat,
    startLong,
    startImg,
  ) async {
    try {
      currentStatus = ApiResponseStatus.loading;
      notifyListeners();

      _passiveModel = await AuthReposityory().toSendEndCarNoPhoto(
        context,
        payload,
        carId,
        userId,
        startKm,
        startLat,
        startLong,
        startImg,
      );
      currentStatus = ApiResponseStatus.succesfull;
      Preferences().tokenDelete();
      Preferences().autoLogInDelete();
      Preferences().qrIdDelete();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const PassivatedScreen(),
        ),
      );
    } catch (e) {
      currentStatus = ApiResponseStatus.error;
    }
    currentStatus = ApiResponseStatus.noDefinations;
    notifyListeners();
  }

  Future<void> sendActivation(context, payload, controller, code) async {
    try {
      currentStatus = ApiResponseStatus.loading;
      notifyListeners();

      _activationModel =
          await AuthReposityory().toSendActivationCode(context, payload, code);
      currentStatus = ApiResponseStatus.succesfull;
    } catch (e) {
      currentStatus = ApiResponseStatus.error;
      controller?.back(
        onTap: (currentIndex) {},
      );
    }
    currentStatus = ApiResponseStatus.noDefinations;
    notifyListeners();
  }

  Future<void> sendQr(context, qrId, isPush) async {
    try {
      currentStatus = ApiResponseStatus.loading;
      notifyListeners();

      _qrModel = await AuthReposityory().toSendQr(context, qrId);

      currentStatus = ApiResponseStatus.succesfull;
      isPush
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CarInformationScreen(),
              ))
          : null;
    } catch (e) {
      currentStatus = ApiResponseStatus.error;
    }
    currentStatus = ApiResponseStatus.noDefinations;
    notifyListeners();
  }

  void requestLocation(context) async {
    var locationStatus = await Permission.location.status;
    notifyListeners();
    if (locationStatus.isGranted) {
      var position = await Geolocator.getCurrentPosition();
      _lat = position.latitude;
      _long = position.longitude;

      notifyListeners();
    } else if (locationStatus.isDenied || locationStatus.isPermanentlyDenied) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PermissionScreen(),
          ));
      notifyListeners();
    }
    currentStatus = ApiResponseStatus.noDefinations;
    notifyListeners();
  }

  Future<void> getQuestions(context) async {
    try {
      currentStatus = ApiResponseStatus.loading;

      _questionModel = await AuthReposityory().toGetQuestions(context);
      currentStatus = ApiResponseStatus.succesfull;
    } catch (e) {
      currentStatus = ApiResponseStatus.error;
    }
    currentStatus = ApiResponseStatus.noDefinations;
    notifyListeners();
  }

  /*void requestLocation(context) async {
    var locationStatus = await Permission.location.status;
    currentStatus = ApiResponseStatus.loading;
    notifyListeners();
    if (locationStatus.isGranted) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
      currentStatus = ApiResponseStatus.succesfull;
      notifyListeners();
    } else if (locationStatus.isDenied || locationStatus.isPermanentlyDenied) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PermissionScreen(),
          ));
      currentStatus = ApiResponseStatus.succesfull;
      notifyListeners();
    }
  }*/
}
