// ignore_for_file: file_names
import 'package:CarTracker/constants/constants.dart';
import 'package:CarTracker/global_variables.dart';
import 'package:CarTracker/models/file_model.dart';
import 'package:CarTracker/screens/carKmPhoto/car_km_photo_screen.dart';
import 'package:CarTracker/widgets/upload_widget.dart';
import 'package:flutter/material.dart';


class CarPhotoScreen extends StatefulWidget {
  const CarPhotoScreen({Key? key}) : super(key: key);

  @override
  State<CarPhotoScreen> createState() => _CarPhotoScreenState();
}

class _CarPhotoScreenState extends State<CarPhotoScreen> {
  List<FileModel> frontImg = [];
  List<FileModel> backImg = [];
  List<FileModel> leftImg = [];
  List<FileModel> rightImg = [];
  List<FileModel> insideImg = [];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.12,
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
                        if (frontImg.isEmpty ||
                            backImg.isEmpty ||
                            rightImg.isEmpty ||
                            insideImg.isEmpty ||
                            leftImg.isEmpty) {
                          Utils.showToastAlert(
                              context, "Araç fotoğraflarını çekiniz");
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CarKmPhotoScreen(
                                    insideImg: insideImg,
                                    frontImg: frontImg,
                                    backImg: backImg,
                                    rightImg: rightImg,
                                    leftImg: leftImg),
                              ));
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
                      : const Text(
                          'Devam edin',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xff1f2b51),
        resizeToAvoidBottomInset: false,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        UploadImageWidget(
                            getFileList: frontImg,
                            title: "Aracın önden fotoğrafını çekiniz",
                            isAlert: true),
                        const SizedBox(
                          height: 10,
                        ),
                        UploadImageWidget(
                            getFileList: backImg,
                            title: "Aracın arkadan fotoğrafını çekiniz",
                            isAlert: true),
                        const SizedBox(
                          height: 10,
                        ),
                        UploadImageWidget(
                            getFileList: rightImg,
                            title: "Aracın sağdan fotoğrafını çekiniz",
                            isAlert: true),
                        const SizedBox(
                          height: 10,
                        ),
                        UploadImageWidget(
                            getFileList: leftImg,
                            title: "Aracın soldan fotoğrafını çekiniz",
                            isAlert: true),
                        const SizedBox(
                          height: 10,
                        ),
                        UploadImageWidget(
                            getFileList: insideImg,
                            title: "Aracın içten fotoğrafını çekiniz",
                            isAlert: true),
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
    );
  }
}
