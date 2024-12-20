import 'dart:async';

import 'package:CarTracker/constants/constants.dart';
import 'package:CarTracker/global_variables.dart';
import 'package:CarTracker/viewModel/send_view.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ActivationPage extends StatefulWidget {
  const ActivationPage({super.key});

  @override
  State<ActivationPage> createState() => _ActivationPageState();
}

class _ActivationPageState extends State<ActivationPage> {
  int countdown = 150;
  late Timer timer;
  String? verificationCode;
  final pinController1 = TextEditingController();
  final focusNode = FocusNode();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 75,
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: Colors.white,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: const Color(0xff61afff),
      ),
    ),
  );
  void startCountdownTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startCountdownTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SendViewModel>(context);
    return SingleChildScrollView(
      child: currentStatus == ApiResponseStatus.loading
          ? const Center(
              child: CircularProgressIndicator(
              color: Color(0xff61afff),
            ))
          : Center(
              child: provider.loginModel.data!.isCode!
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constants().padding),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            child: Pinput(
                              keyboardType: TextInputType.number,
                              length: 5,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: defaultPinTheme.copyWith(
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  color: const Color(0xff61afff),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                              ),
                              submittedPinTheme: defaultPinTheme.copyWith(
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  color: const Color(0xff61afff),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                              ),
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              controller: pinController1,
                              focusNode: focusNode,
                              androidSmsAutofillMethod:
                                  AndroidSmsAutofillMethod.smsUserConsentApi,
                              listenForMultipleSmsOnAndroid: true,
                              hapticFeedbackType:
                                  HapticFeedbackType.lightImpact,
                              onCompleted: (pin) {
                                verificationCode = pin;
                                GlobalVariables.activationCode =
                                    verificationCode;
                                setState(() {});
                                debugPrint('onCompleted: $pin');
                              },
                            ),
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: countdown > 0
                                ? null
                                : () {
                                    setState(() {
                                      countdown = 90;
                                      startCountdownTimer();
                                    });
                                  },
                            child: Text(
                              countdown > 0
                                  ? "${AppLocalizations.of(context)!.modal_sheet_activation_resend_text} ($countdown)"
                                  : AppLocalizations.of(context)!
                                      .modal_sheet_activation_resend_text,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: countdown > 01
                                    ? const Color(0xff61afff).withOpacity(0.5)
                                    : const Color(0xff61afff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Image.asset(
                      "assets/images/onay-ikon.png",
                      color: const Color(0xff61afff),
                    ),
            ),
    );
  }
}
