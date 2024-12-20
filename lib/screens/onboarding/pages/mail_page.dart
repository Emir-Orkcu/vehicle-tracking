// ignore_for_file: unnecessary_null_comparison

import 'package:CarTracker/constants/constants.dart';
import 'package:CarTracker/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MailPage extends StatefulWidget {
  const MailPage({super.key});

  @override
  State<MailPage> createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  TextEditingController mailController = TextEditingController();
  TextEditingController tenantController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xffd8e5f0),
                borderRadius: BorderRadius.circular(20)),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Padding(
              padding: EdgeInsets.only(
                  top: Constants().padding * 2,
                  left: Constants().padding * 2,
                  right: Constants().padding * 2,
                  bottom: Constants().padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .modal_sheet_mail_organisation_text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  TextFormField(
                    onEditingComplete: () {
                      GlobalVariables.tenantCode = tenantController.text;
                      setState(() {});
                    },
                    onChanged: (value) {
                      GlobalVariables.tenantCode = tenantController.text;
                      setState(() {});
                    },
                    controller: tenantController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .modal_sheet_mail_organisation_hint_text;
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    cursorColor: const Color(0xff000C66),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        hintText: AppLocalizations.of(context)!
                            .modal_sheet_mail_organisation_hint_text,
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0),
                          ),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0),
                          ),
                        ),
                        errorStyle: const TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xffd8e5f0),
                borderRadius: BorderRadius.circular(20)),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Padding(
              padding: EdgeInsets.only(
                  top: Constants().padding * 2,
                  left: Constants().padding * 2,
                  right: Constants().padding * 2,
                  bottom: Constants().padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.modal_sheet_mail_text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  TextFormField(
                    onEditingComplete: () {
                      GlobalVariables.email = mailController.text;
                      setState(() {});
                    },
                    onChanged: (value) {
                      GlobalVariables.email = mailController.text;
                      setState(() {});
                    },
                    controller: mailController,
                    validator: (value) {
                      if (value == null ||
                          !RegExp(r'\S+@\S+\.\S+').hasMatch(value) ||
                          value.length > 255) {
                        return AppLocalizations.of(context)!.modal_sheet_mail_hint_text;
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    cursorColor: const Color(0xff000C66),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        hintText: AppLocalizations.of(context)!
                            .modal_sheet_mail_hint_text,
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0),
                          ),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0),
                          ),
                        ),
                        errorStyle: const TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xffd8e5f0),
                borderRadius: BorderRadius.circular(20)),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Padding(
              padding: EdgeInsets.only(
                  top: Constants().padding * 2,
                  left: Constants().padding * 2,
                  right: Constants().padding * 2,
                  bottom: Constants().padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.modal_sheet_password_text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  TextFormField(
                    onEditingComplete: () {
                      GlobalVariables.password = passwordController.text;
                      setState(() {});
                    },
                    onChanged: (value) {
                      GlobalVariables.password = passwordController.text;
                      setState(() {});
                    },
                    controller: passwordController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Parola geçerli değildir";
                      } else if (val.length > 255) {
                        return "Parola geçerli değildir";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    cursorColor: const Color(0xff000C66),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        hintText: AppLocalizations.of(context)!.modal_sheet_password_hint_text,
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0),
                          ),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0),
                          ),
                        ),
                        errorStyle: const TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          ),
          /* Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants().padding * 3,
            ),
            child: Row(
              children: [
                Checkbox(
                  activeColor: Colors.blue,
                  value: rememberMe,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value!;
                    });
                  },
                ),
                const Text("Beni Hatırla"),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}
