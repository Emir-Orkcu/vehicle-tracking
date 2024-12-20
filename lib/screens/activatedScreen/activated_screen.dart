import 'package:CarTracker/screens/mainScreen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:CarTracker/constants/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActivatedScreen extends StatefulWidget {
  const ActivatedScreen({Key? key}) : super(key: key);

  @override
  State<ActivatedScreen> createState() => _ActivatedScreenState();
}

class _ActivatedScreenState extends State<ActivatedScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1f2b51),
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
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
                    padding:
                        EdgeInsets.symmetric(vertical: Constants().padding * 9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/onay-ikon.png",
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          AppLocalizations.of(context)!.car_activate_text,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
