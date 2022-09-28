import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);
 TextStyle get hd1 {
    return GoogleFonts.lato(
            color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,

    );
  }
    TextStyle get subhd1 {
    return GoogleFonts.lato(
            color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,

    );
  }
  TextStyle get titlestyle {
    return GoogleFonts.lato(
            color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,

    );
  }
  TextStyle get subtitle {
    return GoogleFonts.lato(
            color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,

    );
  }
  TextStyle get bodystyle {
    return GoogleFonts.lato(
            color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,

    );
  }
  TextStyle get body2 {
    return GoogleFonts.lato(
            color: Get.isDarkMode ? Colors.grey[200] : Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,

    );
  }
    TextStyle get datestyle {
    return GoogleFonts.actor(
            color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.w400,

    );
  }

class Themes {
  static final light = ThemeData(
      primaryColor: primaryClr,
      backgroundColor: white,
      brightness: Brightness.light);
  static final dark = ThemeData(

    primaryColor: darkGreyClr,
    backgroundColor: darkGreyClr,
    brightness: Brightness.dark,
  );
 

}
