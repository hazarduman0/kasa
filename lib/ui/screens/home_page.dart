import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasa/controllers/bottom_sheet_controller.dart';
import 'package:kasa/controllers/category_controller.dart';
import 'package:kasa/core/constrants/app_colors.dart';
import 'package:kasa/core/constrants/app_keys.dart';
import 'package:kasa/core/constrants/app_keys_textstyle.dart';
import 'package:kasa/ui/widgets/home/activity_timeline.dart';
import 'package:kasa/ui/widgets/home/month_comparison_card.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final BottomSheetController sheetController = Get.find();
  final CategoryController categoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(AppKeys.menuText,
                              style: AppKeysTextStyle.menuTextStyle)),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    const Align(
                        alignment: Alignment.center,
                        child: MonthComparisonCard()), //ListViewBuilder
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: SizedBox(
                width: Get.width,
                child: Card(
                  margin: EdgeInsets.zero,
                  //color: Colors.red,
                  color: AppColors.bakeryBox,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.05,
                        vertical: Get.height * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Son 30 gün'),
                            Text('+4.342,02',
                                style: AppKeysTextStyle.currentBalanceStyle)
                          ],
                        ),
                        Expanded(
                          child: ListView(
                            //listviewBuilder
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            children: [
                              ActivityTimeLine(
                                  amount: -500,
                                  date: '24/07/2022',
                                  name: 'Faturalar'),
                              ActivityTimeLine(
                                  amount: -400,
                                  date: '25/07/2022',
                                  name: 'Online Alışveriş'),
                              ActivityTimeLine(
                                  amount: -800,
                                  date: '27/07/2022',
                                  name: 'Mutfak Alışverişi'),
                              ActivityTimeLine(
                                  amount: -2000,
                                  date: '28/07/2022',
                                  name: 'kira'),
                              ActivityTimeLine(
                                  amount: 11000,
                                  date: '31/07/2022',
                                  name: 'Maaş'),
                              SizedBox(height: Get.height * 0.1)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(elevation: 0.0, items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.rotate_left_outlined),
            label: 'Son İşlemler',
            backgroundColor: AppColors.maximumBlueGreen),
        BottomNavigationBarItem(
            icon: const Icon(Icons.incomplete_circle_outlined),
            label: 'Profit',
            backgroundColor: AppColors.maximumBlueGreen),
        BottomNavigationBarItem(
          icon: GetBuilder<BottomSheetController>(builder: (sheet) {
            return IconButton(
              onPressed: () {
                sheet.isRemoveFunc(false);
                _getBottomSheet();
              },
              icon: Icon(Icons.add_circle_outlined,
                  color: AppColors.maximumBlueGreen, size: 35.0),
            );
          }),
          label: '',
          backgroundColor: AppColors.maximumBlueGreen,
        ),
      ]),
      floatingActionButton: GetBuilder<BottomSheetController>(builder: (sheet) {
        return FloatingActionButton(
          elevation: 0.0,
          onPressed: () {
            sheet.isRemoveFunc(true);
            _getBottomSheet();
          },
          child: Icon(Icons.remove_outlined),
          backgroundColor: AppColors.silkenRuby,
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }

  Future<dynamic> _getBottomSheet() {
    return Get.bottomSheet(elevation: 0.0, isScrollControlled: true,
        GetBuilder<BottomSheetController>(builder: (sheet) {
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
                    height: Get.height * 0.1,
                    width: Get.width,
                    child: GetBuilder<CategoryController>(builder: (category) {
                      return DropdownButtonFormField(
                        hint: const Text('Kategori Seçin'),
                        //value: 'ali',
                         dropdownColor: Colors.white,
                        items: generateDropDownMenuItemList(),
                        onChanged: (value) {
                          category.selectCategory(value);
                        },
                      );
                    })),
              ],
            )),
      );
    }));
  }

  List<DropdownMenuItem<String>> generateDropDownMenuItemList() {
    List<DropdownMenuItem<String>> dropDownMenuItems = [];
    if (sheetController.isRemove) {
      for (var item in categoryController.expenseList) {
        dropDownMenuItems.add(
            DropdownMenuItem(value: item.category, child: Center(child: Text(item.category))));
      }
    } else {
      for (var item in categoryController.incomeList) {
        dropDownMenuItems.add(
            DropdownMenuItem(value: item.category, child: Center(child: Text(item.category))));
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
}