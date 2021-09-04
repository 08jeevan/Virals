import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:virals/Screens/UI/WallpaperLandingPage.dart';

class WallpaperCollectionTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              height: 30.0,
              color: Colors.transparent,
              child: Center(
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  labelPadding:
                      EdgeInsets.only(left: 0.0, right: 3.0, top: 0.0),
                  tabs: [
                    Tab(
                      icon: Icon(Octicons.primitive_dot, size: 17.0),
                    ),
                    Tab(
                      icon: Icon(Octicons.primitive_dot, size: 17.0),
                    ),
                    Tab(
                      icon: Icon(Octicons.primitive_dot, size: 17.0),
                    ),
                    Tab(
                      icon: Icon(Octicons.primitive_dot, size: 17.0),
                    ),
                    Tab(
                      icon: Icon(Octicons.primitive_dot, size: 17.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              WallpaperCollection(
                label:
                    "https://raw.githubusercontent.com/08jeevan/WallJson/master/WallpaperJson/AmoledWalls.json",
                title: "Amoled",
              ),
              WallpaperCollection(
                label:
                    "https://raw.githubusercontent.com/08jeevan/WallJson/master/WallpaperJson/MinimalWalls.json",
                title: "Minimal",
              ),
              WallpaperCollection(
                label:
                    "https://raw.githubusercontent.com/08jeevan/WallJson/master/WallpaperJson/ColorfulWalls.json",
                title: "Colorful",
              ),
              WallpaperCollection(
                label:
                    "https://raw.githubusercontent.com/08jeevan/WallJson/master/WallpaperJson/LandScapeWalls.json",
                title: "Landscape",
              ),
              WallpaperCollection(
                label:
                    "https://raw.githubusercontent.com/08jeevan/WallJson/master/WallpaperJson/PatternWalls.json",
                title: "Pattern",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
