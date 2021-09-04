import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:virals/Constants/SubmitSetUpConstant.dart';
import 'package:virals/Constants/Universal.dart';

class SubmitSetup extends StatefulWidget {
  @override
  _SubmitSetupState createState() => _SubmitSetupState();
}

class _SubmitSetupState extends State<SubmitSetup> {
  String setupname,
      setupauthorname,
      setupauthorinstaortwitterid,
      launcherapp,
      wallpaperapp,
      widget1app,
      widget2app,
      widget3app,
      iconsapp;

  String dw;

  final formKey = GlobalKey<FormState>();

  // // // Image Picker // // //

  File _setupimage;
  File _setupwallpaper;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _setupimage = File(pickedFile.path);
    });
  }

  Future getWallpaper() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _setupwallpaper = File(pickedFile.path);
    });
  }

  Future uploadSetup(BuildContext context) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref()
        .child("usersubmission/HomeScreen/setup" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_setupimage);

    uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
  }

  Future uploadWall(BuildContext context) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref()
        .child("usersubmission/wallpaper/wall" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_setupwallpaper);

    uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
  }

  // // // SUBMISSION OF SETUPS // // //
  final DocumentReference documentReference =
      FirebaseFirestore.instance.collection("usersubmissions").doc();

  void _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      Map<String, String> data = <String, String>{
        "SetUpName": setupname,
        "SetUp Author Name": setupauthorname,
        "SetUp Author Id": setupauthorinstaortwitterid,
        "01laun": launcherapp,
        "02wallapp": wallpaperapp,
        "03wid1": widget1app,
        "03wid2": widget2app,
        "03wid3": widget3app,
        "04icon": iconsapp,
        "time": DateTime.now().toString()
      };
      documentReference.set(data).whenComplete(() {
        print("Submitted secussfully");
      }).catchError((e) => print(e));
    }
  }
  // // // // // // // // // // // // //

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 30.0),
                  // This is the image picking part. select image from gallery

                  Center(
                    child: Container(
                      height: 200.0,
                      width: 100.0,
                      child: _setupimage == null
                          ? Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    color: Colors.grey,
                                    onPressed: getImage,
                                  ),
                                  Text(
                                    "ScreenShot",
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.file(
                                _setupimage,
                                fit: BoxFit.fill,
                                height: 200.0,
                                width: 100.0,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  // This is a Text Form Feild.
                  // Setup author name
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextField(
                                style: ktesxtformfieldstyle,
                                decoration: kusernameStyle,
                                onChanged: (input) => setupauthorname = input,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // setup author instagram and insta id
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextField(
                                style: ktesxtformfieldstyle,
                                decoration: kuseridStyle,
                                onChanged: (input) =>
                                    setupauthorinstaortwitterid = input,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // // Setup name
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextField(
                                style: ktesxtformfieldstyle,
                                decoration: ksetupnamestyle,
                                onChanged: (input) => setupname = input,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // // launcher
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextField(
                                style: ktesxtformfieldstyle,
                                decoration: klauncherappStyle,
                                onChanged: (input) => launcherapp = input,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // // wallpaper
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextField(
                                style: ktesxtformfieldstyle,
                                decoration: kwallpaperappStyle,
                                onChanged: (input) => wallpaperapp = input,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          _setupwallpaper == null
                              ? Container(
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: IconButton(
                                    icon: Icon(Icons.add),
                                    color: Colors.grey,
                                    onPressed: getWallpaper,
                                  ),
                                )
                              : Container(
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Image.file(
                                        _setupwallpaper,
                                        fit: BoxFit.fill,
                                        height: 45.0,
                                        width: 33.0,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  // // widget1
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextField(
                                style: ktesxtformfieldstyle,
                                decoration: kwidget1appStyle,
                                onChanged: (input) => widget1app = input,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // // widget (if any)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextField(
                                style: ktesxtformfieldstyle,
                                decoration: kwidget2appStyle,
                                onChanged: (input) => widget2app = input,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextField(
                                style: ktesxtformfieldstyle,
                                decoration: kwidget3appStyle,
                                onChanged: (input) => widget3app = input,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // // icons
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextField(
                                style: ktesxtformfieldstyle,
                                decoration: kiconsappStyle,
                                onChanged: (input) => iconsapp = input,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    elevation: 0.0,
                    color: kbuttoncolor,
                    child: Text("Submit", style: ksetUpSubmit),
                    onPressed: () {
                      if (_setupimage == null) {
                        print("Add Setup screenshot");
                        showTopSnackBar(
                          context,
                          CustomSnackBar.error(
                              message: "Add Setup screenshot",
                              textStyle: ksubmitconst),
                        );
                      } else if (setupauthorname == null) {
                        print(" username empty");
                        showTopSnackBar(
                          context,
                          CustomSnackBar.error(
                              message: "Please Submit your Full name",
                              textStyle: ksubmitconst),
                        );
                      } else if (setupname == null) {
                        print(" setupname empty");
                        showTopSnackBar(
                          context,
                          CustomSnackBar.error(
                              message: "Please Provide a Title for your Setup",
                              textStyle: ksubmitconst),
                        );
                      } else if (launcherapp == null) {
                        print(" launcher empty");
                        showTopSnackBar(
                          context,
                          CustomSnackBar.error(
                              message: "Please Enter Launcher name",
                              textStyle: ksubmitconst),
                        );
                      } else {
                        Navigator.pop(context);
                        uploadSetup(context);
                        uploadWall(context);
                        _submit();
                        showTopSnackBar(
                          context,
                          CustomSnackBar.success(
                            message:
                                "Your Setup detailes has been secussfully submitted",
                            icon: Icon(Icons.tab, color: Colors.transparent),
                            textStyle: ksubmitconst,
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
