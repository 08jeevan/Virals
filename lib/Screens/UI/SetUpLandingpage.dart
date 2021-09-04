import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virals/Constants/Universal.dart';
import 'package:virals/Constants/HomeScreenConst.dart';
import 'package:virals/Screens/HomeScreens/SetupdetailPage.dart';

class LandingpageSetups extends StatefulWidget {
  final String collname, setupname, label;
  final String label2, label3, label4;

  LandingpageSetups(
      {this.collname,
      this.setupname,
      this.label,
      this.label2,
      this.label3,
      this.label4});

  @override
  _LandingpageSetupsState createState() => _LandingpageSetupsState(
      collname, setupname, label, label2, label3, label4);
}

class _LandingpageSetupsState extends State<LandingpageSetups> {
  final String collname, setupname, label;
  final String label2, label3, label4;
  _LandingpageSetupsState(this.collname, this.setupname, this.label,
      this.label2, this.label3, this.label4);

  static const _adUnitID = "ca-app-pub-1082417208908203/3430257126";
  final _nativeAdController = NativeAdmobController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("HomeScreenSetups")
              .where('category', whereIn: [
            label.toString(),
            label2.toString(),
            label3.toString(),
            label4.toString(),
          ]).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: kcircularProgressIndicator,
                    strokeWidth: 2,
                  ),
                ),
              );
            } else {
              return ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 20.0, 0.0, 10.0),
                    child: Container(
                      child: Text(
                        setupname.toString(),
                        style: GoogleFonts.ubuntu(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot setups =
                            snapshot.data.documents[index];
                        return Container(
                          child: Column(
                            children: [
                              SizedBox(height: 5.0),
                              index != 0 && (index % 5) == 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      height: 250.0,
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              30.0, 5.0, 30.0, 5.0),
                                          child: NativeAdmob(
                                            // Your ad unit id
                                            adUnitID: _adUnitID,
                                            controller: _nativeAdController,
                                            type: NativeAdmobType.full,
                                            loading: Container(
                                              height: 12.0,
                                              width: 12.0,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: 2.0,
                                                  backgroundColor:
                                                      Color(0xff3a0ca3),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(height: 10.0),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SetupDetailPage(
                                      collectionName: collname.toString(),
                                      documentID: "${setups.data()["docID"]}",
                                      image: "${setups.data()["simg"]}",
                                    );
                                  }));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 5.0,
                                  ),
                                  child: Card(
                                    elevation: 0.8,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    margin: EdgeInsets.all(0.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            4.0,
                                            4.0,
                                            4.0,
                                            0.0,
                                          ),
                                          child: Container(
                                            height: 320.0,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                "${setups.data()["simg"]}",
                                                fit: BoxFit.fill,
                                                cacheHeight: 700,
                                                cacheWidth: 700,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Container(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 13.0,
                                                          width: 13.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: loadingProgress
                                                                        .expectedTotalBytes !=
                                                                    null
                                                                ? loadingProgress
                                                                        .cumulativeBytesLoaded /
                                                                    loadingProgress
                                                                        .expectedTotalBytes
                                                                : null,
                                                            valueColor:
                                                                kcircularProgressIndicator,
                                                            strokeWidth: 2,
                                                          ),
                                                        ),
                                                        SizedBox(width: 8.0),
                                                        Container(
                                                          child: Text(
                                                            "Loading ...",
                                                            style: GoogleFonts
                                                                .sourceSansPro(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: 8.0,
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                    "${setups.data()["sname"]}",
                                                    style: ksetupname,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                ),
                                                child: Text("|",
                                                    style: TextStyle(
                                                        color: Colors.grey)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                ),
                                                child: Container(
                                                  width: 80.0,
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                    "${setups.data()["sauthor"]}",
                                                    style: ksetupauthor,
                                                    overflow: TextOverflow.fade,
                                                    softWrap: false,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 25.0,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
