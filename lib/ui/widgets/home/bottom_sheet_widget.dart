import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasa/controllers/bottom_sheet_controller.dart';
import 'package:kasa/controllers/category_controller.dart';
import 'package:kasa/core/constrants/app_colors.dart';
import 'package:kasa/core/constrants/app_keys.dart';
import 'package:kasa/core/constrants/app_keys_textstyle.dart';

class BottomSheetWidget extends StatelessWidget {
  BottomSheetWidget({Key? key}) : super(key: key);

  final BottomSheetController sheetController = Get.find();
  final CategoryController categoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomSheetController>(builder: (context) {
      return Container(
        height: Get.height * 0.8,
        width: Get.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bottomSheetCancelButton(),
                SizedBox(height: Get.height * 0.05),
                _buttonRow(),
                SizedBox(height: Get.height * 0.03),
                SizedBox(
                    height: Get.height * 0.15,
                    width: Get.width,
                    child: GetBuilder<CategoryController>(builder: (category) {
                      return DropdownButtonFormField(
                        hint: Text('Kategori Seçin',
                            style: AppKeysTextStyle.buttonTextStyle
                                .copyWith(color: AppColors.blackHowl)),
                        //isDense: true,
                        //value: 'ali',
                        iconEnabledColor: AppColors.blackHowl,
                        iconDisabledColor: AppColors.blackHowl,
                        style: AppKeysTextStyle.dropDownMenuItemTextStyle,
                        borderRadius: BorderRadius.circular(15.0),
                        items: generateDropDownMenuItemList(),
                        onChanged: (value) {
                          category.selectCategory(value);
                        },
                      );
                    })),
              ],
            )),
      );
    });
  }

  Align _bottomSheetCancelButton() {
    return Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Text(AppKeys.cancel,
                  style: AppKeysTextStyle.cancelTextStyle)),
        ));
  }

  List<DropdownMenuItem<String>> generateDropDownMenuItemList() {
    List<DropdownMenuItem<String>> dropDownMenuItems = [];
    if (sheetController.isRemove) {
      for (var item in categoryController.expenseList) {
        dropDownMenuItems.add(DropdownMenuItem(value: item, child: Text(item)));
      }
    } else {
      for (var item in categoryController.incomeList) {
        dropDownMenuItems.add(DropdownMenuItem(value: item, child: Text(item)));
      }
    }
    return dropDownMenuItems;
  }

  Padding _buttonRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _fixedButton(sheetController.isRemove
              ? AppKeys.fixedExpense
              : AppKeys.fixedIncome),
          _extraButton(
              sheetController.isRemove ? AppKeys.unexpected : AppKeys.extra)
        ],
      ),
    );
  }

  SizedBox _extraButton(String name) {
    return SizedBox(
      width: Get.width * 0.43,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0.0,
              primary: !sheetController.isFixedChoosen
                  ? AppColors.enchantingSapphire
                  : AppColors.nieblaAzul),
          onPressed: () {
            sheetController.extraButtonFunc();
          },
          child: Text(name, style: AppKeysTextStyle.buttonTextStyle)),
    );
  }

  SizedBox _fixedButton(String name) {
    return SizedBox(
      width: Get.width * 0.43,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0.0,
              primary: sheetController.isFixedChoosen
                  ? AppColors.enchantingSapphire
                  : AppColors.nieblaAzul),
          onPressed: () {
            sheetController.fixedButtonFunc();
          },
          child: Text(name, style: AppKeysTextStyle.buttonTextStyle)),
    );
  }
}
