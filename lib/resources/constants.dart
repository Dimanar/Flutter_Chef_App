import 'package:flutter/material.dart';

class AppConstant {
  AppConstant._();

  static const kPrimaryColor = Color(0xFF0C9869);
  static const kTextColor = Color(0xFF3C4046);
  static const kBackgroundColor = Color(0xFFF9F8FD);
  static const String TITLE = 'RaRe Chief-cooker';
  static const String more = 'More';
  static const String iconMenu = 'assets/icons/menu.svg';
  static const double kDefaultPadding = 40.0;
  static const String greetings = 'Hi Chief-cooker!';
  static const String forSearch = 'Search';
  static const String IconForSearch = 'assets/icons/search.svg';

  static const String ApiBaseUrl = 'http://127.0.0.1:5000/';
  static const String recipes = 'recipes/';
}

class SplashConstant {
  SplashConstant._();

  static const String splash_photo = 'assets/images/for_splash.png';
  static const String splash_bg = 'assets/images/splash_bg.png';
  static const String splash_str = '  \tRaRe\t\n Chief-cooker';
  static const Color kSplashColorStart = Colors.green;
  static const Color kSplashColorEnd = Colors.lightGreenAccent;
}

class AppErrors {
  AppErrors._();
  static const simpleError = "ERROR";
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static Size size;
  static double screenWidth;
  static double screenHeight;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    size = _mediaQueryData.size;
    screenHeight =  _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    orientation = _mediaQueryData.orientation;
  }
}


