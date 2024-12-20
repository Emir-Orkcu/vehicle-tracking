// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:CarTracker/global_variables.dart';
import 'package:CarTracker/screens/crashScreen/crash_screen.dart';
import 'package:CarTracker/screens/onboarding/main_sign_screen.dart';
import 'package:CarTracker/screens/passiveScreen/end_car_photo_screen.dart';
import 'package:CarTracker/screens/passiveScreen/end_km_photo_screen.dart';
import 'package:CarTracker/sharedPreferences/shared_preferences.dart';
import 'package:CarTracker/viewModel/send_view.dart';
import 'package:gif/gif.dart';
import 'package:flutter/material.dart';
import 'package:CarTracker/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late GifController _controllerGif;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  int milliseconds = 0;
  late Timer? timer;
  bool isRunning = true;

  @override
  void initState() {
    super.initState();
    _controllerGif = GifController(vsync: this);
    carIsActive();
    apiRes();
    // Sayacı otomatik başlat
    startCounter();
  }

  @override
  void dispose() {
    // Timer'ı iptal et
    timer?.cancel();
    _controllerGif.dispose();
    super.dispose();
  }

  // Sayaçı güncelle
  void updateCounter() {
    setState(() {
      milliseconds += 100;
      if (milliseconds >= 1000) {
        milliseconds = 0;
        seconds++;
      }
      if (seconds >= 60) {
        seconds = 0;
        minutes++;
      }
      if (minutes >= 60) {
        minutes = 0;
        hours++;
      }
    });
  }

  void apiRes() async {
    await context
        .read<SendViewModel>()
        .sendQr(context, await Preferences().getQrId(), false);
  }

  void carIsActive() async {
    await context.read<SendViewModel>().sendIsActive(context);
    context.read<SendViewModel>().isActive.data!.isActive!
        ? null
        : showDialog<void>(
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
  }

  // Sayaçı başlat
  void startCounter() {
    timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        updateCounter();
      },
    );
  }

  // Sayaçı durdur
  void stopCounter() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SendViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height * 0.12,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    _makeEmergencyCall();
                  },
                  child: Image.asset(
                    "assets/images/acil-durum.png",
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CrashScreen(),
                        ));
                  },
                  child: Image.asset(
                    "assets/images/kaza-durum.png",
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                )
              ],
            ),
          ),
          backgroundColor: const Color(0xff1f2b51),
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: currentStatus == ApiResponseStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : LayoutBuilder(
                  builder: (BuildContext context,
                      BoxConstraints viewportConstraints) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/arka-plan.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Constants().padding),
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/araç-kullanım-süre-çerçeve.png"),
                                        fit: BoxFit.contain)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: Constants().padding * 4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/arac-saat.png",
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                      ),
                                      Text(
                                          AppLocalizations.of(context)!
                                              .car_main_counter_text,
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // Sayaç değerlerini göster
                                      Text(
                                        '$hours:$minutes:$seconds.${(milliseconds ~/ 10).toString().padLeft(2, '0')}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 38),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Constants().padding * 2),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Constants().padding,
                                                vertical: Constants().padding),
                                            child: Image.network(
                                              provider.qrModel.data?.photo ??
                                                  "",
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.14,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Constants().padding),
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .car_informations_title_text,
                                                  style: const TextStyle(
                                                      color: Color(0xffcea259),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/mercedes-ikon.png",
                                                    width: 25,
                                                  ),
                                                  Text(
                                                    provider.qrModel.data
                                                            ?.brand ??
                                                        "",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    height: 20,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color:
                                                          Colors.red.shade900,
                                                    ),
                                                    child: const Center(
                                                        child: Text(
                                                      "Aktif",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                          color: Colors.white),
                                                    )),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Constants().padding,
                                                      vertical:
                                                          Constants().padding /
                                                              2),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .car_informations_car_plates,
                                                        style: const TextStyle(
                                                            fontSize: 8,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        provider.qrModel.data
                                                                ?.plateNumber ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Constants().padding,
                                                      vertical:
                                                          Constants().padding /
                                                              2),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .car_photo_field_text,
                                                        style: const TextStyle(
                                                            fontSize: 8,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "${GlobalVariables.kilometre} km",
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Constants().padding),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                    Constants().padding),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .car_informations_car_model,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text(
                                                      "111 CDI",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 8),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                    Constants().padding),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .car_informations_car_year,
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      provider.qrModel.data
                                                              ?.brandYear ??
                                                          "",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 8),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                    Constants().padding),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .car_informations_car_color,
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text(
                                                      "Siyah",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 8),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff946c1c),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                    Constants().padding),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .car_informations_peak_date,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      provider.qrModel.data
                                                              ?.insuranceDate ??
                                                          "",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Constants().padding,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  provider.isActive.data!.tenentInfo!
                                          .isEndPhoto!
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const EndCarPhotoScreen(),
                                          ))
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EndCarKmScreen(
                                              backImg: const [],
                                              frontImg: const [],
                                              insideImg: const [],
                                              leftImg: const [],
                                              rightImg: const [],
                                            ),
                                          ));
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width * 0.7,
                                      50),
                                  backgroundColor: const Color(0xff61aefe),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .car_main_passive_button,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Constants().padding * 2,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Constants().padding * 2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .car_main_start_km,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${GlobalVariables.kilometre} km",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 1,
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      color: Colors.white,
                                    ),
                                    Gif(
                                      height: 75,
                                      width: 75,
                                      fit: BoxFit.cover,
                                      image: const AssetImage(
                                          "assets/images/car-gif.gif"),
                                      controller: _controllerGif,
                                      autostart: Autostart.loop,
                                      placeholder: (context) => const Text(
                                        'Loading...',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onFetchCompleted: () {
                                        _controllerGif.reset();
                                        _controllerGif.forward();
                                      },
                                    ),
                                    Container(
                                      height: 1,
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      color: Colors.white,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .car_main_end_km,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "? km",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  void _makeEmergencyCall() async {
    const url = 'tel:112';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
