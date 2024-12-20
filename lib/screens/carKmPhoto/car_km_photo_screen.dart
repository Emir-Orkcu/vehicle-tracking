// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:CarTracker/constants/constants.dart';
import 'package:CarTracker/global_variables.dart';
import 'package:CarTracker/models/file_model.dart';
import 'package:CarTracker/viewModel/send_view.dart';
import 'package:CarTracker/widgets/upload_widget.dart';

class CarKmPhotoScreen extends StatefulWidget {
  List<FileModel> frontImg;
  List<FileModel> backImg;
  List<FileModel> rightImg;
  List<FileModel> leftImg;
  List<FileModel> insideImg;
  CarKmPhotoScreen({
    Key? key,
    required this.frontImg,
    required this.backImg,
    required this.rightImg,
    required this.leftImg,
    required this.insideImg,
  }) : super(key: key);

  @override
  State<CarKmPhotoScreen> createState() => _CarKmPhotoScreenState();
}

class _CarKmPhotoScreenState extends State<CarKmPhotoScreen> {
  List<FileModel> getFileList = [];
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SendViewModel>(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: currentStatus == ApiResponseStatus.loading
                    ? () {}
                    : () {
                        if (controller.text.isEmpty) {
                          Utils.showToastAlert(
                              context,
                              AppLocalizations.of(context)!
                                  .car_photo_field_hint_text);
                        } else {
                          if (provider.loginModel.data!.isCode!){
                            provider.activationModel.data!.isStartPhoto!
                              ? provider.sendCarPhoto(
                                  context,
                                  {"": ""},
                                  getFileList,
                                  provider.qrModel.data?.id,
                                  provider.loginModel.data?.auth?.id,
                                  controller.text,
                                  provider.lat,
                                  provider.long,
                                  widget.frontImg,
                                  widget.backImg,
                                  widget.rightImg,
                                  widget.leftImg,
                                  getFileList,
                                  widget.insideImg)
                              : provider.sendCarNoPhoto(
                                  context,
                                  {"": ""},
                                  getFileList,
                                  provider.qrModel.data?.id,
                                  provider.loginModel.data?.auth?.id,
                                  controller.text,
                                  provider.lat,
                                  provider.long,
                                  getFileList);
                          }else{
                            provider.loginModel.data!.tenantInfoDTO!.isStartPhoto!
                              ? provider.sendCarPhoto(
                                  context,
                                  {"": ""},
                                  getFileList,
                                  provider.qrModel.data?.id,
                                  provider.loginModel.data?.auth?.id,
                                  controller.text,
                                  provider.lat,
                                  provider.long,
                                  widget.frontImg,
                                  widget.backImg,
                                  widget.rightImg,
                                  widget.leftImg,
                                  getFileList,
                                  widget.insideImg)
                              : provider.sendCarNoPhoto(
                                  context,
                                  {"": ""},
                                  getFileList,
                                  provider.qrModel.data?.id,
                                  provider.loginModel.data?.auth?.id,
                                  controller.text,
                                  provider.lat,
                                  provider.long,
                                  getFileList);
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.7, 50),
                  backgroundColor: const Color(0xff61aefe),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: currentStatus == ApiResponseStatus.loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      :  Text(
                          AppLocalizations.of(context)!.car_photo_button_text,
                          style:const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.car_photo_bottom_text,
                style: TextStyle(
                    fontSize: 10, color: Colors.black.withOpacity(0.7)),
              )
            ],
          ),
        ),
        backgroundColor: const Color(0xff1f2b51),
        resizeToAvoidBottomInset: true,
        extendBody: false,
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: Constants().padding * 3,
                                bottom: Constants().padding),
                            child: UploadImageWidget(
                                title: AppLocalizations.of(context)!.car_photo_text,
                                getFileList: getFileList,
                                isAlert: false),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constants().padding * 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                   Text(
                                    AppLocalizations.of(context)!.car_informations_title_text,
                                    style:const TextStyle(
                                        color: Color(0xffcea259),
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/mercedes-ikon.png",
                                        width: 35,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        "Mercedes Benz Vito",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                      "assets/images/araç-vites-ikon.png"),
                                  const Text(
                                    "Manuel",
                                    style: TextStyle(
                                      color: Color(0xffcea259),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(Constants().padding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    AppLocalizations.of(context)!.car_photo_field_text,
                                    style:const TextStyle(
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextFormField(
                                    onChanged: (value) {
                                      GlobalVariables.kilometre =
                                          controller.text;
                                      setState(() {});
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: controller,
                                    decoration:  InputDecoration(
                                      hintText: AppLocalizations.of(context)!.car_photo_field_hint_text,
                                      border: InputBorder.none,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
    );
  }
}
