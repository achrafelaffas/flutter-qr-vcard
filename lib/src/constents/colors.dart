import 'package:flutter/material.dart';

/* -- LIST OF ALL COLORS -- */

const tPrimaryColor = Colors.orange;
const tSecondaryColor = Color(0xFF272727);
const tAccentColor = Color(0xFF001BFF);

const tWhiteColor = Colors.white;
const tDarkColor = Color(0xff000000);
const tCardBgColor = Color(0xFFF7F6F1);

// -- ON-BOARDING COLORS
const tOnBoardingPage1Color = Colors.white;
const tOnBoardingPage2Color = Color(0xfffddcdf);
const tOnBoardingPage3Color = Color(0xffffdcbd);

// ignore: non_constant_identifier_names
InputDecoration InputStyle = const InputDecoration(
    floatingLabelStyle: TextStyle(color: tPrimaryColor),
    focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: tPrimaryColor)),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
      color: tWhiteColor,
    )),
    hintStyle: TextStyle(color: tWhiteColor),
    labelStyle: TextStyle(color: tWhiteColor),
    hintText: 'enter your first name',
    labelText: 'First Name',
    border: OutlineInputBorder());
