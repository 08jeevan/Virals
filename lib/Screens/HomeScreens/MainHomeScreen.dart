import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virals/Constants/Universal.dart';
import 'package:virals/Screens/Explore/SubmitSetup.dart';
import 'package:virals/Screens/Wallpaper/WallpaperCollCategory.dart';
import 'main.dart';
import 'package:intl/intl.dart';
import 'package:virals/Darkthemepreference.dart';

class MainLandingpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    DateTime now = DateTime.now();
    var timeNow = int.parse(DateFormat('kk').format(now));
    var greetingmessage = '';
    Color hscolor1, hscolor2;
    Color wallcolor1, wallcolor2;
    if (timeNow <= 12) {
      greetingmessage = 'Good Morning!';
      hscolor1 = Color(0xff36D1DC);
      hscolor2 = Color(0xff5D88DA);
      wallcolor1 = Color(0xffeea849);
      wallcolor2 = Color(0xfff46b45);
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      greetingmessage = 'Good Afternoon!';
      hscolor1 = Color(0xff36D1DC);
      hscolor2 = Color(0xff5B86E5);
      wallcolor1 = Color(0xff38ef7d);
      wallcolor2 = Color(0xff11998e);
    } else if ((timeNow > 16) && (timeNow < 20)) {
      greetingmessage = 'Good Evening!';
      hscolor1 = Color(0xffFEAC5E);
      hscolor2 = Color(0xffC779D0);
      wallcolor1 = Color(0xff93EDC7);
      wallcolor2 = Color(0xff2BC0E4);
    } else {
      greetingmessage = 'Good Night!';
      hscolor1 = Color(0xff5FC3E4);
      hscolor2 = Color(0xff8E54E9);
      wallcolor1 = Color(0xffff9472);
      wallcolor2 = Color(0xfff2709c);
    }

    void _submitSetups() {
      showModalBottomSheet<void>(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(15.0),
            topRight: const Radius.circular(15.0),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 290.0,
            child: new Container(
              child: Card(
                margin: EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(15.0),
                    topRight: const Radius.circular(15.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: UniversalSliderDash(),
                    ),
                    SizedBox(height: 2.0),
                    Container(
                      height: 30.0,
                      child: Center(
                          child: Text("Submit",
                              style: GoogleFonts.sourceSansPro(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500,
                              ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Do you have any Cool looking HomeScreen Setup? Upload them here and get featured!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 25.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xffff565f),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white38,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    height: 45.0,
                                    width: 45.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return SubmitSetup();
                                            }));
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: '04jeevancrasta@gmail.com',
        queryParameters: {'subject': 'Found_an_Bug'});

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                height: 25.0,
                width: 25.0,
                child: Image.asset("Images/applogo.png"),
              ),
              SizedBox(width: 8.0),
              Text("Virals", style: GoogleFonts.sourceSansPro()),
            ],
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        endDrawer: Drawer(
          elevation: 5.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DrawerTiles(
                        onTap: () {},
                        icon: MaterialCommunityIcons.theme_light_dark,
                        label: "Theme",
                        trail: Switch(
                          onChanged: (bool value) {
                            themeChange.darkTheme = value;
                          },
                          value: themeChange.darkTheme,
                          activeColor: Color(0xff3a0ca3),
                          inactiveThumbColor: Color(0xff3a0ca3),
                        ),
                      ),
                      DrawerTiles(
                        onTap: () {
                          Share.share(
                            "Check Out this Amazing app With Cool Home Screen Setups and Wallpapers. You will love it. \n https://play.google.com/store/apps/details?id=com.JeevanCrasta.virals",
                          );
                        },
                        icon: Ionicons.md_share_alt,
                        label: "Share App",
                        trail: Container(
                          height: 0.0,
                          width: 0.0,
                        ),
                      ),
                      DrawerTiles(
                        onTap: () async {
                          launch(
                              "https://play.google.com/store/apps/details?id=com.JeevanCrasta.virals");
                        },
                        icon: Ionicons.ios_star,
                        label: "Rate us",
                        trail: Container(
                          height: 0.0,
                          width: 0.0,
                        ),
                      ),
                      DrawerTiles(
                        onTap: () {
                          launch(_emailLaunchUri.toString());
                        },
                        icon: FontAwesome.bug,
                        label: "Report Bug",
                        trail: Container(
                          height: 0.0,
                          width: 0.0,
                        ),
                      ),
                      DrawerTiles(
                        onTap: () {
                          Navigator.pop(context);
                          _submitSetups();
                        },
                        icon: Feather.upload,
                        label: "Submit Setup",
                        trail: Container(
                          height: 0.0,
                          width: 0.0,
                        ),
                      ),
                      DrawerTiles(
                        onTap: () {
                          launch("https://t.me/HoMeScReEnSeTUpss");
                        },
                        icon: FontAwesome5Brands.telegram_plane,
                        label: "Join Telegram",
                        trail: Container(
                          height: 0.0,
                          width: 0.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    SizedBox(width: 16.0),
                    DrawerTilesBottom(
                      icon: AntDesign.instagram,
                      ontap: () {
                        launch("https://www.instagram.com/jeeevaan._/");
                      },
                    ),
                    SizedBox(width: 4.0),
                    DrawerTilesBottom(
                      icon: FontAwesome5Brands.telegram_plane,
                      ontap: () {
                        launch("https://t.me/Jeevancrasta");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    greetingmessage.toString(),
                    style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.w700,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ),
              HomeScreenTiles(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SetUpCollectionTabs();
                  }));
                },
                color1: hscolor1,
                color2: hscolor2,
                label: "HomeScreens",
                sublabel: "80+ Setups | 4 Categories",
              ),
              HomeScreenTiles(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WallpaperCollectionTabs();
                  }));
                },
                color1: wallcolor1,
                color2: wallcolor2,
                label: "Wallpapers",
                sublabel: "150+ Walls | 5 Categories",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreenTiles extends StatelessWidget {
  final Function onTap;
  final Color color1, color2;
  final String label, sublabel;

  HomeScreenTiles({
    this.onTap,
    this.color1,
    this.color2,
    this.label,
    this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Stack(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    color1,
                    color2,
                  ],
                ),
              ),
              height: 150.0,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      15.0,
                      15.0,
                      0.0,
                      2.0,
                    ),
                    child: Text(
                      label,
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      sublabel,
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 12.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerTilesBottom extends StatelessWidget {
  final Function ontap;
  final IconData icon;
  DrawerTilesBottom({this.icon, this.ontap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50.0,
        width: 50.0,
        child: Card(
          elevation: 0.0,
          child: Center(
            child: Icon(icon, size: 18.0),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DrawerTiles extends StatelessWidget {
  Function onTap;
  String label;
  IconData icon;
  Widget trail;

  DrawerTiles({this.onTap, this.label, this.icon, this.trail});

  @override
  Widget build(BuildContext context) {
    return ListViewTile(
      onTap: onTap,
      icon: icon,
      label: label,
      trail: trail,
    );
  }
}

class ListViewTile extends StatelessWidget {
  final Function onTap;
  final String label;
  final Widget trail;
  final IconData icon;

  ListViewTile({this.onTap, this.label, this.icon, this.trail});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 20.0,
      ),
      title: Text(
        label,
        style: GoogleFonts.sourceSansPro(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trail,
    );
  }
}
