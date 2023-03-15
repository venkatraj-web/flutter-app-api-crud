import 'package:flutter/material.dart';

Color primary = const Color(0xFF01A4D0);
class Styles{
  static Color primaryColor = primary;
  static Color secondaryColor = const Color(0xFFE47B01);
  static Color lightBgColor = const Color(0xFFF8FDFF);
  static Color darkBgColor = const Color(0xFF2E394A);

  // ================Text=====================
  static Color textColor = const Color(0xFF00313E);
  static Color textLightColor = const Color(0xFF757575);
  static TextStyle textStyle = TextStyle(fontSize: 16, color: textColor,fontWeight: FontWeight.w500);
  static TextStyle headLineStyle1 = TextStyle(fontSize: 26, color: textColor,fontWeight: FontWeight.bold);
  static TextStyle headLineStyle2 = TextStyle(fontSize: 21, color: textColor,fontWeight: FontWeight.bold);
  static TextStyle headLineStyle3 = TextStyle(fontSize: 17, color: textColor,fontWeight: FontWeight.w500);
  static TextStyle headLineStyle4 = TextStyle(fontSize: 14, color: textColor,fontWeight: FontWeight.w500);

  // ===========Alert Color====
  static Color successColor = const Color(0xFF7EC15F);
  static Color errorColor = const Color(0xFFDA0424);
  static Color warningColor = const Color(0xFFFFBB01);


}