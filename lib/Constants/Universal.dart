import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kcircularProgressIndicator =
    AlwaysStoppedAnimation<Color>(Color(0xff3a0ca3));

const kcircularProgressIndicatorsize = 18.0;

const kbuttoncolor = Color(0xff3a0ca3);

const kcontainercolor = Color(0xff3a0ca3);

final ksubmitconst = GoogleFonts.sourceSansPro(
  fontSize: 15.0,
);

class UniversalSliderDash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.0,
      width: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.grey.withOpacity(0.5),
      ),
    );
  }
}

class WallSettingMenu extends StatelessWidget {
  final Function onTap;
  final IconData icon;

  WallSettingMenu({this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      child: Container(
        height: 55.0,
        width: 55.0,
        child: Card(
          elevation: 0.1,
          child: Center(
            child: Icon(
              icon,
              size: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
