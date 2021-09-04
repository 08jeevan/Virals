import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:virals/Constants/HomeScreenConst.dart';
import 'package:virals/Constants/Universal.dart';
import 'package:virals/Screens/Wallpaper/WallpaperDownloadPage.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class WallWithLaunchUrl extends StatefulWidget {
  const WallWithLaunchUrl({
    this.setupappname,
    this.setupappurl,
    this.icon,
  });

  final String setupappname, setupappurl, icon;

  @override
  _WallWithLaunchUrlState createState() =>
      _WallWithLaunchUrlState(setupappname, setupappurl, icon);
}

class _WallWithLaunchUrlState extends State<WallWithLaunchUrl> {
  _WallWithLaunchUrlState(
    this.setupappname,
    this.setupappurl,
    this.icon,
  );

  final String setupappname, setupappurl, icon;

  bool _isRewardedAdLoaded = false;
  bool _isRewardedVideoComplete = false;

  downloadaImage() async {
    await ImageDownloader.downloadImage(
      setupappurl,
      destination: AndroidDestinationType.custom(
        directory: "Viral Setups",
      ),
    );
  }

  String _wallpaperHomeScreen = 'Unknown';
  String _wallpaperLockScreen = 'Unknown';

  Future<void> setWallpaperForHomescreen() async {
    setState(() {
      _wallpaperHomeScreen = "Setting Wallpaper";
      Text('Setting Wallpaper');
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(setupappurl);
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
    var file = await DefaultCacheManager().getSingleFile(setupappurl);
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0),
            ),
          ),
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              height: 265,
              child: Column(
                children: [
                  Center(child: UniversalSliderDash()),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          width: 120.0,
                          height: 200.0,
                          child: Image.network(
                            widget.setupappurl,
                            fit: BoxFit.fill,
                            width: 120.0,
                            // (loadingBuilder: (BuildContext context, Widget child,
                            //     ImageChunkEvent loadingProgress) {
                            //   if (loadingProgress == null) return child;
                            //   return Container(
                            //     height: 15.0,
                            //     width: 15.0,
                            //     child: Center(
                            //       child: Container(
                            //         height: 18.0,
                            //         width: 18.0,
                            //         child: CircularProgressIndicator(
                            //           valueColor: kcircularProgressIndicator,
                            //           strokeWidth: 2,
                            //         ),
                            //       ),
                            //     ),
                            //   );
                            // }
                            // ),
                          ),
                        ),
                      ),
                      SizedBox(width: 25.0),
                      WallSettingMenu(
                        onTap: () {
                          downloadaImage();
                          showTopSnackBar(
                            context,
                            SnatchBar(
                              msg: "Downloading Wallpaper",
                            ),
                          );
                        },
                        icon: (Feather.download),
                      ),
                      WallSettingMenu(
                        onTap: () {
                          showTopSnackBar(
                            context,
                            SnatchBar(
                              msg: "Applying Wallpaper",
                            ),
                          );
                          setWallpaperForHomescreen();
                          setWallpaperForLockscreen();
                        },
                        icon: (Icons.format_paint),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        height: 38.0,
        margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              height: 30.0,
              width: 30.0,
              child: SvgPicture.asset(
                widget.icon,
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              child: Text(
                widget.setupappname,
                style: ksetuptilename,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// If the Submitted wallpaper is an app then call this class
class AppsWithLaunchUrl extends StatelessWidget {
  const AppsWithLaunchUrl({
    this.setupappname,
    this.setupappurl,
    this.icon,
  });

  final String setupappname, setupappurl, icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await LaunchApp.openApp(
          androidPackageName: setupappurl,
        );
      },
      child: Container(
        height: 38.0,
        margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              height: 30.0,
              width: 30.0,
              child: SvgPicture.asset(
                icon,
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              child: Text(
                setupappname,
                style: ksetuptilename,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
