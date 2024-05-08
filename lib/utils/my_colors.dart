import 'package:flutter/material.dart';

class MyColors{
  static Color appPrimaryColor = HexColor("2B407D");
  static Color greenSnackBar = HexColor("4AC000");
  static Color orangeSnackBar = HexColor("EF9300");
  static Color redSnackBar = HexColor("E01A1A");
  static Color greenPinPut = HexColor("35C2C1");
  static Color redOpacity = HexColor("FF9191");
  static Color greenDiscount = HexColor("5DCB6A");
  static Color bluePrice = HexColor("2754C5");
  static Color grey = HexColor("9B9B9B");
  static Color greyOpacity = HexColor("CDD4D3");
  static Color redEmergencyMenu = HexColor("C93131");
  static Color redTimer = HexColor("F71A1A");
  static Color greySeeAll = HexColor("8391A1");
  static Color blackMenu = HexColor("1F2340");
  static Color greyPromo = HexColor("77838F");
  static Color greyReview = HexColor("878787");
  static Color blueOpacity = HexColor("D7E1FE");
  static Color redNotification = HexColor("FF5959");
  static Color listChatColor = HexColor("2754C51A");
  static Color greyButton = HexColor("8391A1");
  static Color greyLanguage = HexColor('3C3C3C45');
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}