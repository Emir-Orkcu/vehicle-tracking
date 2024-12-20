// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:CarTracker/constants/constants.dart';
import 'package:CarTracker/models/file_model.dart';
import 'package:CarTracker/widgets/popover.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class UploadImageWidget extends StatefulWidget {
  final List<FileModel> getFileList;
  final bool isAlert;
  final String title;
  const UploadImageWidget(
      {super.key,
      required this.getFileList,
      required this.title,
      required this.isAlert});

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  final picker = ImagePicker();
  List emptyFileList = [];
  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      File file = File(pickedFile!.path);
      FileModel newF = FileModel(
          file: file,
          fileTitle: file.path.split('/').last,
          filePath: file.path,
          devicePath: file.path);
      widget.getFileList.add(newF);
    });
  }

  void requestCameraPermission() async {
    var cameraStatus = await Permission.camera.status;

    if (cameraStatus.isGranted) {
      print("Permission camera and galery is granted");
      widget.getFileList.isEmpty
          ? showModalBottomSheet<int>(
              backgroundColor: Colors.white,
              context: context,
              builder: (context) {
                return Popover(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            onImageButtonPressed(ImageSource.camera);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Fotoğraf Çek",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              onImageButtonPressed(ImageSource.gallery);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Galeriden Seç",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              "İptal",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )),
                      ),
                    ],
                  ),
                );
              },
            )
          : null;
    } else if (cameraStatus.isDenied) {
      // Kullanıcı, bu izni bir daha asla sormayacak şekilde reddetti.
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Kamera ve Galeri izni gerekli",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: Text(
            "Fotoğraf çekebilmeniz ve Galeriden görsel seçebilmeniz için uygulamanızın Kamera ve Galeri iznini kabul etmeniz gerekir.",
            style: TextStyle(color: Colors.black.withOpacity(0.8)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Tamam",
                style: TextStyle(color: Colors.black.withOpacity(0.8)),
              ),
            ),
            TextButton(
              onPressed: () => openAppSettings(),
              child: Text(
                "Ayarlar",
                style: TextStyle(color: Colors.black.withOpacity(0.8)),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Constants().padding),
      child: UploadPhoto(
        title: widget.title,
        isAlert: widget.isAlert,
        onPressed: () {
          requestCameraPermission();
        },
        children: widget.getFileList.isEmpty
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(
                    widget.getFileList[0].file!,
                    width: MediaQuery.of(context).size.width * 0.5,
                    fit: BoxFit.cover,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.getFileList.removeAt(0);
                        });
                      },
                      icon: const Icon(Icons.cancel, color: Colors.red))
                ],
              ),
      ),
    );
  }

  void onImageButtonPressed(ImageSource source) async {
    try {
      await getImage(source);
    } catch (e) {
      print(e);
    }
  }
}

// ignore: must_be_immutable
class UploadPhoto extends StatelessWidget {
  UploadPhoto(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.children,
      required this.isAlert})
      : super(key: key);
  final bool isAlert;
  final Widget children;
  final String title;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Constants().padding),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Constants().padding,
                  horizontal: Constants().padding),
              child: GestureDetector(
                onTap: onPressed,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/foto-ikon.png",
                        width: MediaQuery.of(context).size.width * 0.12,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        title,
                        style: const TextStyle(fontSize: 16),
                      )
                    ]),
              ),
            ),
            children
          ],
        ),
      ),
    );
  }
}
