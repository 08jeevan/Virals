import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virals/Constants/HomeScreenConst.dart';
import 'package:virals/Constants/Universal.dart';
import 'package:virals/Screens/HomeScreens/Const/SetUpPageConst.dart';

class SetupDetailPage extends StatefulWidget {
  final String documentID, collectionName, image;
  SetupDetailPage({
    this.documentID,
    this.collectionName,
    this.image,
  });

  @override
  _SetupDetailPageState createState() =>
      _SetupDetailPageState(documentID, collectionName, image);
}

class _SetupDetailPageState extends State<SetupDetailPage> {
  String documentID, collectionName, image;
  _SetupDetailPageState(
    this.documentID,
    this.collectionName,
    this.image,
  );

  static const _adUnitID = "ca-app-pub-1082417208908203/6977129207";
  final _nativeAdController = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("HomeScreenSetups")
              .doc(documentID)
              .snapshots(),
          builder: (context, snapshot) {
            var homescreenSetups = snapshot.data;
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 330.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          child: Image.network(
                            image,
                            fit: BoxFit.fill,
                            cacheHeight: 700,
                            cacheWidth: 700,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                      child: Card(
                        elevation: 1.5,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15.0),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 15.0, 0.0, 0.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      homescreenSetups.data()["sname"] ?? "",
                                      style: ksetupviewname,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  launch("https://www.instagram.com/" +
                                      homescreenSetups.data()["sauthorid"]);
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15.0, 8.0, 0.0, 0.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "By, " +
                                            homescreenSetups.data()["sauthor"],
                                        style: ksetupviewauthorname,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Divider(
                                color: Colors.grey,
                                indent: 40.0,
                                endIndent: 40.0,
                              ),
                              homescreenSetups.data()["01laun"] == null
                                  ? Container()
                                  : Container(
                                      child: AppsWithLaunchUrl(
                                        setupappname:
                                            homescreenSetups["01laun"],
                                        setupappurl:
                                            homescreenSetups["01launurl"],
                                        icon: "Images/home.svg",
                                      ),
                                    ),
                              homescreenSetups.data()["02wall"] == null
                                  ? Container()
                                  : Container(
                                      child: WallWithLaunchUrl(
                                        icon: "Images/wallpaper.svg",
                                        setupappname: homescreenSetups
                                            .data()["02wall"]
                                            .toString(),
                                        setupappurl: homescreenSetups
                                            .data()["02wallurl"],
                                      ),
                                    ),
                              homescreenSetups.data()["02wallapp"] == null
                                  ? Container()
                                  : Container(
                                      child: AppsWithLaunchUrl(
                                        setupappname:
                                            homescreenSetups["02wallapp"],
                                        setupappurl:
                                            homescreenSetups["02wallappurl"],
                                        icon: "Images/wallpaper.svg",
                                      ),
                                    ),
                              homescreenSetups.data()["03wid1"] == null
                                  ? Container()
                                  : Container(
                                      child: AppsWithLaunchUrl(
                                        setupappname:
                                            homescreenSetups["03wid1"],
                                        setupappurl:
                                            homescreenSetups["03wid1url"],
                                        icon: "Images/widget.svg",
                                      ),
                                    ),
                              homescreenSetups.data()["03wid2"] == null
                                  ? Container()
                                  : Container(
                                      child: AppsWithLaunchUrl(
                                        setupappname:
                                            homescreenSetups["03wid2"],
                                        setupappurl:
                                            homescreenSetups["03wid2url"],
                                        icon: "Images/widget.svg",
                                      ),
                                    ),
                              homescreenSetups.data()["03wid3"] == null
                                  ? Container()
                                  : Container(
                                      child: AppsWithLaunchUrl(
                                        setupappname:
                                            homescreenSetups["03wid3"],
                                        setupappurl:
                                            homescreenSetups["03wid3url"],
                                        icon: "Images/widget.svg",
                                      ),
                                    ),
                              homescreenSetups.data()["03wid4"] == null
                                  ? Container()
                                  : Container(
                                      child: AppsWithLaunchUrl(
                                        setupappname:
                                            homescreenSetups["03wid4"],
                                        setupappurl:
                                            homescreenSetups["03wid4url"],
                                        icon: "Images/widget.svg",
                                      ),
                                    ),
                              homescreenSetups.data()["04icon"] == null
                                  ? Container()
                                  : Container(
                                      child: AppsWithLaunchUrl(
                                        setupappname:
                                            homescreenSetups["04icon"],
                                        setupappurl:
                                            homescreenSetups["04iconurl"],
                                        icon: "Images/icons.svg",
                                      ),
                                    ),
                              SizedBox(height: 10.0),
                              homescreenSetups.data()["05backup"] == null
                                  ? Container()
                                  : Column(
                                      children: [
                                        Divider(
                                          color: Colors.grey,
                                          indent: 40.0,
                                          endIndent: 40.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 5.0),
                                          child: ExpandablePanel(
                                            header: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: Text(
                                                "Backup & More",
                                                style: ksetupviewauthorname,
                                                softWrap: true,
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            expanded: Column(
                                              children: [
                                                Text(
                                                  homescreenSetups
                                                      .data()["05backup"],
                                                  style: ksetupviewauthorname,
                                                  textAlign: TextAlign.center,
                                                  softWrap: true,
                                                ),
                                                SizedBox(height: 5.0),
                                                homescreenSetups.data()[
                                                            "05backupurl"] ==
                                                        null
                                                    ? Container()
                                                    : Center(
                                                        child:
                                                            RaisedButton.icon(
                                                          color: kbuttoncolor,
                                                          elevation: 0.0,
                                                          onPressed: () {
                                                            launch(
                                                              homescreenSetups
                                                                      .data()[
                                                                  "05backupurl"],
                                                            );
                                                          },
                                                          icon: Icon(
                                                              Icons.backup,
                                                              color:
                                                                  Colors.white,
                                                              size: 20.0),
                                                          label: Text(
                                                            "GET BACKUP",
                                                            style:
                                                                kbackupicontheme,
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                            tapHeaderToExpand: true,
                                            hasIcon: false,
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 5.0),
                      child: Container(
                        height: 50.0,
                        child: NativeAdmob(
                          adUnitID: _adUnitID,
                          controller: _nativeAdController,
                          type: NativeAdmobType.banner,
                          loading: Container(),
                          options: NativeAdmobOptions(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
