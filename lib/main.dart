import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:virals/Darkthemepreference.dart';
import 'MainHomeScreen.dart';
import 'Screens/UI/SetUpLandingpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Virals());
}

class Virals extends StatefulWidget {
  @override
  _ViralsState createState() => _ViralsState();
}

class _ViralsState extends State<Virals> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: MainLandingpage(),
          );
        },
      ),
    );
  }
}

class SetUpCollectionTabs extends StatelessWidget {
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
                  labelPadding:
                      EdgeInsets.only(left: 0.0, right: 3.0, top: 0.0),
                  indicatorColor: Colors.transparent,
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
              LandingpageSetups(
                collname: "HomeScreenSetups",
                setupname: "Latest",
                label: "colorful",
                label2: "minimal",
                label3: "amoled",
                label4: "dark",
              ),
              LandingpageSetups(
                collname: "HomeScreenSetups",
                setupname: "Amoled",
                label: "amoled",
              ),
              LandingpageSetups(
                collname: "HomeScreenSetups",
                setupname: "Colorful",
                label: "colorful",
              ),
              LandingpageSetups(
                collname: "HomeScreenSetups",
                setupname: "Minimal",
                label: "minimal",
              ),
              LandingpageSetups(
                collname: "HomeScreenSetups",
                setupname: "Dark",
                label: "dark",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
