import 'package:flutter/material.dart';

class AppColors {
  static Color liquoriceBlack = const Color.fromRGBO(53, 44, 52, 1.0);
  static Color blackHowl = const Color.fromRGBO(33, 31, 45, 1.0);
  static Color limonana = const Color.fromRGBO(27, 218, 110, 1.0);
  static Color bakeryBox = const Color.fromRGBO(240, 244, 242, 1.0);
  static Color maximumBlueGreen = const Color.fromRGBO(49, 181, 191, 1.0);
  static Color silkenRuby = const Color.fromRGBO(230, 15, 36, 1.0);
  static Color brightAqua = const Color.fromRGBO(11, 244, 228, 1.0);
  static Color goldenLuck = const Color.fromRGBO(244, 188, 31, 1.0);  //selectedButtonTextColor
  static Color flingGreen = const Color.fromRGBO(142, 210, 210, 1.0); //unselectedButtonTextColor
  static Color sparkyBlue = const Color.fromRGBO(31, 241, 244, 1.0);  //selectedButton
  static Color nieblaAzul = const Color.fromRGBO(180, 197, 197, 1.0); //unselectedButton
  static Color enchantingSapphire = const Color.fromRGBO(46, 97, 214, 1.0);

  static LinearGradient currentBalanceCardLinearGradient = const LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        Color.fromRGBO(206, 227, 232, 1.0),
        Color.fromRGBO(230, 240, 242, 1.0)
      ]);

  static LinearGradient mainPageLinearGradient = const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color.fromRGBO(219, 240, 237, 0.73),
      Color.fromRGBO(119, 244, 219, 0.41)
    ]);

  static LinearGradient dateRangeLinearGradient =  const LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      Color.fromRGBO(108, 237, 216, 1.0),
      Color.fromRGBO(32, 231, 191, 1.0),
    ]);      
}
