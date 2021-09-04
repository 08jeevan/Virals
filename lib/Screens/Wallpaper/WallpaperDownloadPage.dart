import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:virals/Constants/Universal.dart';
import 'package:virals/Screens/Wallpaper/helper/helperclass.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

const testDevices = "Your_DEVICE_ID";

class WallpaperDownloadPage extends StatefulWidget {
  final String image, appbarname, auth;
  WallpaperDownloadPage({this.image, this.appbarname, this.auth});

  @override
  _WallpaperDownloadPageState createState() => _WallpaperDownloadPageState();
}

class _WallpaperDownloadPageState extends State<WallpaperDownloadPage> {
  PanelController _pc = PanelController();

// Ads

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevices != null ? <String>['testDevices'] : null,
    keywords: <String>['Book', 'Game'],
    nonPersonalizedAds: true,
  );

  int _coins = 0;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  InterstitialAd _interstitialAd;

  @override
  void initState() {
    super.initState();

    videoAd.load(
        adUnitId: "ca-app-pub-1082417208908203/3621828819",
        targetingInfo: targetingInfo);
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-1082417208908203~4492992825");

    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("REWARDED VIDEO AD $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          // _coins += rewardAmount;
        });
      }
    };
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: "ca-app-pub-1082417208908203/8874155490",
        //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
        });
  }

  // Setting Wallpaper For HomeScreen and LockSreen
  String _wallpaperHomeScreen = 'Unknown';
  String _wallpaperLockScreen = 'Unknown';

  Future<void> setWallpaperForHomescreen() async {
    setState(() {
      _wallpaperHomeScreen = "Setting Wallpaper";
      Text('Setting Wallpaper');
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(widget.image);
    try {
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.HOME_SCREEN);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    if (!mounted) return;
    setState(() {
      _wallpaperHomeScreen = result;
    });
  }

  Future<void> setWallpaperForLockscreen() async {
    setState(() {
      _wallpaperLockScreen = "Loading";
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(widget.image);
    try {
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.LOCK_SCREEN);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    if (!mounted) return;
    setState(() {
      _wallpaperLockScreen = result;
    });
  }

  ///////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        createInterstitialAd()
          ..load()
          ..show();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: SlidingUpPanel(
            backdropEnabled: true,
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                    // loadingBuilder: (BuildContext context, Widget child,
                    //     ImageChunkEvent loadingProgress) {
                    //   if (loadingProgress == null) return child;
                    //   return Center(
                    //     child: CircularProgressIndicator(
                    //       value: loadingProgress.expectedTotalBytes != null
                    //           ? loadingProgress.cumulativeBytesLoaded /
                    //               loadingProgress.expectedTotalBytes
                    //           : null,
                    //       valueColor: kcircularProgressIndicator,
                    //       strokeWidth: 4.0,
                    //     ),
                    //   );
                    // },
                  ),
                ),
              ],
            ),
            panel: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                margin: EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: UniversalSliderDash(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              WallSettingMenu(
                                icon: Icons.format_paint,
                                onTap: () {
                                  return showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      content: Container(
                                        height: 170.0,
                                        child: Column(
                                          children: [
                                            WallpaperSettingOptions(
                                              icon: AntDesign.home,
                                              label: "Set As HomeScreen",
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                                setWallpaperForHomescreen();
                                                showTopSnackBar(
                                                  context,
                                                  SnatchBar(
                                                    msg: "Applying Wallpaper",
                                                  ),
                                                );
                                              },
                                            ),
                                            WallpaperSettingOptions(
                                              icon: AntDesign.unlock,
                                              label: "Set As LockScreen",
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                                setWallpaperForLockscreen();
                                                showTopSnackBar(
                                                  context,
                                                  SnatchBar(
                                                    msg: "Applying Wallpaper",
                                                  ),
                                                );
                                              },
                                            ),
                                            WallpaperSettingOptions(
                                              icon: MaterialCommunityIcons
                                                  .select_compare,
                                              label: "Set As Both",
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                                setWallpaperForHomescreen();
                                                setWallpaperForLockscreen();
                                                showTopSnackBar(
                                                  context,
                                                  SnatchBar(
                                                    msg: "Applying Wallpaper",
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: 12.0),
                              WallSettingMenu(
                                icon: (Feather.download),
                                onTap: () {
                                  videoAd.show();
                                  downloadaImage();
                                  showTopSnackBar(
                                    context,
                                    SnatchBar(
                                      msg: "Downloading Wallpaper",
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
            minHeight: 40.0,
            maxHeight: 120.0,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }

  downloadaImage() async {
    await ImageDownloader.downloadImage(
      widget.image,
      destination: AndroidDestinationType.custom(
        directory: "Virals",
      ),
    );
  }
}

class SnatchBar extends StatelessWidget {
  final String msg;
  SnatchBar({this.msg});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Container(
        height: 35.0,
        child: CustomSnackBar.success(
          icon: Icon(
            Icons.format_paint,
            color: Colors.transparent,
          ),
          textStyle: GoogleFonts.sourceSansPro(
            color: Colors.white,
            fontSize: 18.0,
          ),
          message: msg,
        ),
      ),
    );
  }
}
