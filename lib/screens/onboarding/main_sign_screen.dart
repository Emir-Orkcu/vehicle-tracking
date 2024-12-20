// ignore_for_file: use_build_context_synchronously, duplicate_ignore, unused_local_variable
import 'package:CarTracker/global_variables.dart';
import 'package:CarTracker/models/activation_model.dart';
import 'package:CarTracker/models/login_model.dart';
import 'package:CarTracker/screens/onboarding/pages/Qr_page.dart';
import 'package:CarTracker/sharedPreferences/shared_preferences.dart';
import 'package:CarTracker/viewModel/send_view.dart';
import 'package:CarTracker/viewModel/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:CarTracker/constants/constants.dart';
import 'package:CarTracker/screens/onboarding/pages/activation_page.dart';
import 'package:CarTracker/screens/onboarding/pages/mail_page.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:stepper_a/stepper_a.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainSignScreen extends StatefulWidget {
  const MainSignScreen({Key? key}) : super(key: key);

  @override
  State<MainSignScreen> createState() => _MainSignScreenState();
}

class _MainSignScreenState extends State<MainSignScreen> {
  final _formKey = GlobalKey<FormState>();
  late final PageController _pageController2;
  late int selectedPage2;
  late StepperAController? controllerStep;

  /* Future<void> loadRememberMeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('rememberMe') ?? false;
      if (rememberMe) {
        emailController.text = prefs.getString('email') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  Future<void> saveRememberMeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', rememberMe);
    if (rememberMe) {
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
    }
  }
*/
  @override
  void initState() {
    super.initState();
    selectedPage2 = 0;
    _pageController2 = PageController(initialPage: selectedPage2);
    controllerStep = StepperAController();
  }

  @override
  void dispose() {
    _pageController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff1f2b51),
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Form(
                key: _formKey,
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
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
                          vertical: Constants().padding * 4),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            width: MediaQuery.of(context).size.width * 0.35,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context)!.main_sign_title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 60),
                          Text(
                            AppLocalizations.of(context)!.main_sign_subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: PageView(
                              controller: _pageController2,
                              onPageChanged: (page) {
                                setState(() {
                                  selectedPage2 = page;
                                });
                              },
                              children: List.generate(4, (index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Constants().padding),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .main_sign_animated_text,
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 10),
                          PageViewDotIndicator(
                            size: const Size(15, 15),
                            unselectedSize: const Size(15, 15),
                            currentItem: selectedPage2,
                            count: 4,
                            unselectedColor: Colors.white,
                            selectedColor: const Color(0xff61aefe),
                            duration: const Duration(milliseconds: 200),
                            onItemClicked: (index) {
                              _pageController2.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.19,
                                child: SubmenuButton(
                                    statesController:
                                        MaterialStatesController(),
                                    menuChildren: <Widget>[
                                      MenuItemButton(
                                        onPressed: () async {
                                          await themeProvider
                                              .changeLanguage("tr");
                                        },
                                        child: MenuAcceleratorLabel(
                                            AppLocalizations.of(context)!
                                                .language_tr),
                                      ),
                                      MenuItemButton(
                                        onPressed: () async {
                                          await themeProvider
                                              .changeLanguage("en");
                                        },
                                        child: MenuAcceleratorLabel(
                                            AppLocalizations.of(context)!
                                                .language_en),
                                      ),
                                      MenuItemButton(
                                        onPressed: () async {
                                          await themeProvider
                                              .changeLanguage("fr");
                                        },
                                        child: MenuAcceleratorLabel(
                                            AppLocalizations.of(context)!
                                                .language_fr),
                                      ),
                                    ],
                                    child: Image.asset(
                                      "assets/images/language.png",
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Text(
                                  AppLocalizations.of(context)!
                                      .main_sign_languge_options,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          InkWell(
                            onTap: () {
                              _showModalSheet();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 54,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color(0xff61aefe),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .main_sign_button_text,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
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

  void _showModalSheet() {
    var provider = Provider.of<SendViewModel>(context, listen: false);
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {
            double bottomPadding = MediaQuery.of(context).viewInsets.bottom;
            double sheetHeight =
                MediaQuery.of(context).size.height * 0.7 + bottomPadding;
            return SizedBox(
              height: sheetHeight,
              child: StatefulBuilder(
                builder: (context, setState) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StepperA(
                    stepperAController: controllerStep,
                    stepperSize:
                        Size(MediaQuery.of(context).size.width * 0.7, 90),
                    borderShape: BorderShape.rRect,
                    borderType: BorderType.straight,
                    stepperAxis: Axis.horizontal,
                    lineType: LineType.dotted,
                    stepperBackgroundColor: Colors.transparent,
                    stepHeight: 40,
                    stepWidth: 40,
                    stepBorder: true,
                    pageSwipe: false,
                    formValidation: true,
                    forwardButton: (index) => StepperAButton(
                      width: index == 0 ? 200 : 90,
                      height: 50,
                      onTap: (int currentIndex) async {
                        if (index == 2) {
                          _scan();
                        } else if (index == 0) {
                          if (GlobalVariables.email != null &&
                              GlobalVariables.password != null &&
                              GlobalVariables.tenantCode != null) {
                            await provider.sendLogin(
                                context,
                                LoginModel(
                                        email: GlobalVariables.email,
                                        appCode: 0,
                                        device: Device(
                                            deviceId: GlobalVariables.DeviceID),
                                        tenantCode: int.tryParse(GlobalVariables
                                            .tenantCode
                                            .toString()),
                                        password: GlobalVariables.password)
                                    .toLogin(),
                                controllerStep);
                            provider.loginModel.data!.isCode!
                                ? null
                                : controllerStep?.next(
                                    onTap: (currentIndex) {},
                                  );
                          } else {
                            return null;
                          }
                        } else if (index == 1) {
                          if (GlobalVariables.activationCode != null) {
                            if (GlobalVariables.activationCode!.isNotEmpty) {
                              await provider.sendActivation(
                                  context,
                                  ActivationModel(),
                                  controllerStep,
                                  GlobalVariables.activationCode);
                            } else {
                              return null;
                            }
                          } else {
                            return null;
                          }
                        }
                      },
                      onComplete: () {},
                      buttonWidget: index == 2
                          ? Text(
                              AppLocalizations.of(context)! 
                                  .modal_sheet_qr_button_text,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white))
                          : Text(
                              AppLocalizations.of(context)!
                                  .modal_sheet_button_text,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white)),
                    ),
                    customSteps: [
                      CustomSteps(
                          stepsIcon: Icons.login,
                          title: AppLocalizations.of(context)!
                              .modal_sheet_mail_text),
                      CustomSteps(
                          stepsIcon: Icons.home,
                          title: AppLocalizations.of(context)!
                              .modal_sheet_activate_text),
                      CustomSteps(
                          stepsIcon: Icons.account_circle,
                          title: AppLocalizations.of(context)!
                              .modal_sheet_Qr_text),
                    ],
                    step: const StepA(
                        currentStepColor: Color(0xff61afff),
                        completeStepColor: Color(0xff61afff),
                        inactiveStepColor: Colors.black45,
                        margin: EdgeInsets.all(5)),
                    stepperBodyWidget: const [
                      MailPage(),
                      ActivationPage(),
                      QrPage(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future _scan() async {
    var provider = Provider.of<SendViewModel>(context, listen: false);
    if (await Permission.camera.request().isGranted) {
      String? barcode;
      try {
        // barcode = await scanner.scan();
        Preferences().qrIdAdd("5e816980-fe0f-4d45-bb27-9b628de97d63");
        await provider.sendQr(
            context, "5e816980-fe0f-4d45-bb27-9b628de97d63", true);
      } catch (e) {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) => const AlertDialog(
                  backgroundColor: Colors.white,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Geçersiz Qr")],
                  )),
            );
          },
        );
      }
    } else {
      // Kamera izni verilmemişse kullanıcıya ayarlara gitme seçeneği sun
      var status = await Permission.camera.request();
      if (status.isGranted) {
        // Kullanıcı izin verdiğinde taramayı başlat
        String? barcode = await scanner.scan();
        if (barcode == null) {
          print('nothing return.');
        } else {}
      } else {
        // Kamera izni hala verilmediğinde kullanıcıyı ayarlara yönlendir
        if (await Permission.camera.isPermanentlyDenied) {
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Kamera Erişim İzni'),
                content: const Text(
                    'Uygulamanın kamera kullanabilmesi için kamera erişim izni gereklidir.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Kapat'),
                  ),
                  TextButton(
                    onPressed: () {
                      openAppSettings();
                    },
                    child: const Text('Ayarlar'),
                  ),
                ],
              );
            },
          );
        } else {
          print('Kamera izni hala verilmedi.');
        }
      }
    }
  }
}
