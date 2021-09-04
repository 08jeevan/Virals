import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ktesxtformfieldstyle = GoogleFonts.sourceSansPro(
  fontSize: 13.0,
  fontWeight: FontWeight.w400,
);

final khinttextstyle = GoogleFonts.sourceSansPro(
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
);

const kenabledborder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: Colors.grey));

const kfocusedborder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: Colors.grey));

const kfillColor = Colors.transparent;

final ksubmitstyle = GoogleFonts.sourceSansPro(
  fontWeight: FontWeight.w600,
  fontSize: 22.0,
);

// This Decoration Part is for Launcher, Wallpaper, Widget and Icon ;
final kusernameStyle = InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.all(15),
  hintText: "Enter your name",
  hintStyle: khinttextstyle,
  filled: true,
  fillColor: kfillColor,
  enabledBorder: kenabledborder,
  focusedBorder: kfocusedborder,
);

final kuseridStyle = InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.all(15),
  hintText: "Enter Instagram / twitter Id or Url",
  hintStyle: khinttextstyle,
  filled: true,
  fillColor: kfillColor,
  enabledBorder: kenabledborder,
  focusedBorder: kfocusedborder,
);

final ksetupnamestyle = InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.all(15),
  hintText: "Enter Setup name",
  hintStyle: khinttextstyle,
  filled: true,
  fillColor: kfillColor,
  enabledBorder: kenabledborder,
  focusedBorder: kfocusedborder,
);

final klauncherappStyle = InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.all(15.0),
  hintText: "Launcher App",
  hintStyle: khinttextstyle,
  filled: true,
  fillColor: kfillColor,
  enabledBorder: kenabledborder,
  focusedBorder: kfocusedborder,
);

final kwallpaperappStyle = InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.all(15.0),
  hintText: "Wallpaper App or Link",
  hintStyle: khinttextstyle,
  filled: true,
  fillColor: kfillColor,
  enabledBorder: kenabledborder,
  focusedBorder: kfocusedborder,
);

final kwidget1appStyle = InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.all(15),
  hintText: "Widget App",
  hintStyle: khinttextstyle,
  filled: true,
  fillColor: kfillColor,
  enabledBorder: kenabledborder,
  focusedBorder: kfocusedborder,
);

final kwidget2appStyle = InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.all(15),
  hintText: "Widget App (if any)",
  hintStyle: khinttextstyle,
  filled: true,
  fillColor: kfillColor,
  enabledBorder: kenabledborder,
  focusedBorder: kfocusedborder,
);

final kwidget3appStyle = InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.all(15),
  hintText: "Widget App (if any)",
  hintStyle: khinttextstyle,
  filled: true,
  fillColor: kfillColor,
  enabledBorder: kenabledborder,
  focusedBorder: kfocusedborder,
);

final kiconsappStyle = InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.all(15),
  hintText: "Icon App",
  hintStyle: khinttextstyle,
  filled: true,
  fillColor: kfillColor,
  enabledBorder: kenabledborder,
  focusedBorder: kfocusedborder,
);

// Submit Buttton

final ksetUpSubmit = GoogleFonts.poppins(
  color: Colors.white,
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
);
