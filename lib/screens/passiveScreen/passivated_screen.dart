import 'package:CarTracker/screens/onboarding/main_sign_screen.dart';
import 'package:flutter/material.dart';
import 'package:CarTracker/constants/constants.dart';

class PassivatedScreen extends StatefulWidget {
  const PassivatedScreen({Key? key}) : super(key: key);

  @override
  State<PassivatedScreen> createState() => _PassivatedScreenState();
}

class _PassivatedScreenState extends State<PassivatedScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainSignScreen(),
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
                        const Text(
                          "Aracınız Pasif Olmuştur",
                          style: TextStyle(
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
