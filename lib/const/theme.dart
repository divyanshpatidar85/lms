import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

const Color red = Color.fromARGB(255, 183, 28, 28);
const Color bitterSweet = Color.fromARGB(255, 255, 82, 82);
const Color lightPrimaryColor = Color.fromARGB(255, 255, 123, 123);
const Color melon = Color.fromARGB(255, 255, 186, 186);
const Color white = Colors.white;
const Color darkPrimaryColor = Colors.black;
const double toolbarHeight = 80;

class Themes {
  static final light = ThemeData(
    colorScheme: const ColorScheme.light(primary: Colors.red),
    buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
  );
  static final dark = ThemeData(
      primaryColor: darkPrimaryColor,
      // white10:colors.wait,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark());
  static final white = ThemeData(
      primaryColor: Colors.white,
      // white10:colors.wait,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark());
}

TextStyle get subHeadingStyle {
  return GoogleFonts.getFont(
    'Poppins',
    textStyle: const TextStyle(
        color: darkPrimaryColor,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500),
  );
}

TextStyle headingStyle(BuildContext context) {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 18,
    fontFamily: 'poppin',
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? white : Colors.black,
  ));
}

TextStyle get buttonTextStyle {
  return const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18, color: white);
}

TextStyle get labelStyle {
  return GoogleFonts.getFont(
    'Poppins',
    textStyle: const TextStyle(
        // fontSize:20,
        color: darkPrimaryColor,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600),
  );
}

TextStyle get labelValueStyle {
  return GoogleFonts.getFont(
    'Poppins',
    textStyle: const TextStyle(
        color: darkPrimaryColor,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500),
  );
}

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
