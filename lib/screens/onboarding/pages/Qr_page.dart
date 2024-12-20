// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.modal_sheet_qr_title_text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            AppLocalizations.of(context)!.modal_sheet_qr_subtitle_text,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Image.asset(
                "assets/images/foto-ikon.png",
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              Image.asset(
                "assets/images/qr-kod-çerçeve.png",
                width: MediaQuery.of(context).size.width * 0.3,
              )
            ],
          )
        ],
      ),
    );
  }
}
