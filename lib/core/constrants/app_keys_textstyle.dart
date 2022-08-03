import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasa/core/constrants/app_colors.dart';

class AppKeysTextStyle {
  static TextStyle menuTextStyle = TextStyle(
    color: AppColors.liquoriceBlack,
    fontSize: Get.width * 0.04,
  );
  static TextStyle currentTextStyle = TextStyle(
    color: AppColors.blackHowl,
    fontSize: Get.width * 0.05,
  );
  static TextStyle currentBalanceStyle = TextStyle(
    color: AppColors.limonana,
    fontSize: Get.width * 0.06,
  );
  static TextStyle profitTextStyle = TextStyle(
    color: AppColors.blackHowl,
    fontWeight: FontWeight.bold,
    fontSize: Get.width * 0.06
  );
  static TextStyle timeLineNameTextStyle = TextStyle(
    color: AppColors.blackHowl,
    fontWeight: FontWeight.w600,
    fontSize: Get.width * 0.04
  );
  static TextStyle cardAmountTextStyle = TextStyle(
    color: AppColors.limonana,
    fontWeight: FontWeight.bold,
    fontSize: Get.width * 0.06
  );
  static TextStyle cancelTextStyle = TextStyle(
    color: AppColors.enchantingSapphire,
    fontWeight: FontWeight.w300,
    fontSize: Get.width * 0.05
  );
  static TextStyle buttonTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: Get.width * 0.045
  );
  // static TextStyle selectedButtonTextStyle = TextStyle(
  //   color: AppColors.bakeryBox,
  //   fontWeight: FontWeight.bold,
  //   fontSize: Get.width * 0.05
  // );
  // static TextStyle unselectedButtonTextStyle = TextStyle(
  //   color: AppColors.bakeryBox,
  //   fontWeight: FontWeight.bold,
  //   fontSize: Get.width * 0.05
  // );
  
}
