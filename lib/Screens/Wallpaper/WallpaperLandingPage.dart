import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virals/Constants/Universal.dart';
import 'package:virals/Screens/Wallpaper/WallpaperDownloadPage.dart';

const String testDevice = 'MobileId';

class Wallpapers {
  final String docID;
  final String img;

  Wallpapers._({this.docID, this.img});

  factory Wallpapers.fromJson(Map<String, dynamic> json) {
    return Wallpapers._(
      docID: json['docID'],
      img: json['img'],
    );
  }
}

class WallpaperCollection extends StatefulWidget {
  final String label, title;
  const WallpaperCollection({this.label, this.title});

  @override
  _WallpaperCollectionState createState() => _WallpaperCollectionState();
}

class _WallpaperCollectionState extends State<WallpaperCollection> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario', 'Wallpaper', 'Icons'],
  );

  InterstitialAd _interstitialAd;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: "ca-app-pub-1082417208908203/8874155490",
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
        });
  }

  List<Wallpapers> list = List();
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(widget.label);
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Wallpapers.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  void initState() {
    createInterstitialAd()..load();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 20.0, 0.0, 10.0),
                  child: Container(
                    child: Text(
                      widget.title.toString(),
                      style: GoogleFonts.ubuntu(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                    ),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          createInterstitialAd()
                            ..load()
                            ..show();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return WallpaperDownloadPage(
                                  image: list[index].img,
                                );
                              },
                            ),
                          );
                        },
                        child: Card(
                          elevation: 0.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              (list[index].img.toString()),
                              fit: BoxFit.fill,
                              cacheHeight: 300,
                              cacheWidth: 300,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: Container(
                                    height: 18.0,
                                    width: 18.0,
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                      valueColor: kcircularProgressIndicator,
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
