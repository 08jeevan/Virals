import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Set Wallpaper Popup

class WallpaperSettingOptions extends StatelessWidget {
  final String label;
  final Function onPressed;
  final IconData icon;

  WallpaperSettingOptions({this.icon, this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 15.0,
              top: 25.0,
            ),
            child: Container(
              child: Icon(
                icon,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 20.0,
              top: 25.0,
            ),
            child: Text(
              label,
              style: GoogleFonts.sourceSansPro(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
