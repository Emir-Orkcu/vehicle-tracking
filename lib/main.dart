import 'package:CarTracker/global_variables.dart';
import 'package:CarTracker/screens/screen_routes.dart';
import 'package:CarTracker/sharedPreferences/shared_preferences.dart';
import 'package:CarTracker/viewModel/send_view.dart';
import 'package:CarTracker/viewModel/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => SendViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> initPlatformState() async {
    var language = await Preferences().getLanguage();
    context.read<ThemeProvider>().language = language;
  }

  Future<void> initPlatformState2() async {
    String? androidId;
    try {
      androidId = await  PlatformDeviceId.getDeviceId;
    } on PlatformException {
      androidId = 'Failed to get deviceId.';
    }

    if (!mounted) return;

    setState(() {
      GlobalVariables.DeviceID = androidId;
      print("deviceId->${GlobalVariables.DeviceID}");
    });
  }

  void requestLocaiton() async {
    var locationStatus = await Permission.location.status;
    if (locationStatus.isGranted) {
      print("Permission is granted");
    } else if (locationStatus.isDenied || locationStatus.isPermanentlyDenied) {
      await Permission.location.request();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestLocaiton();
    initPlatformState();
    initPlatformState2();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: initPlatformState(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var provider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            title: 'Vehicle Tracker',
            debugShowCheckedModeBanner: false,
            routes: ScreenRouteList.screenRoutes,
            home: null,
            initialRoute: '/',
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              return null;
            },
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('tr', ''),
              Locale('fr', ''),
            ],
            locale: Locale(provider.language ?? "en"),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
