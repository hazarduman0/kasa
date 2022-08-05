import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasa/controllers/category_controller.dart';
import 'package:kasa/controllers/input_controller.dart';
import 'package:kasa/core/constrants/app_colors.dart';
import 'package:kasa/core/constrants/app_keys.dart';
import 'package:kasa/core/constrants/app_keys_textstyle.dart';
import 'package:kasa/data/models/amount.dart';

class AmountDetailPage extends StatelessWidget {
  AmountDetailPage({Key? key, required this.amount}) : super(key: key);

  Amount amount;

  final InputController inputController = Get.find();

  final CategoryController categoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: Colors.black)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete, color: AppColors.silkenRuby))
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _categoryEdit(),
              //_categorySelectBox(),
              SizedBox(height: Get.height * 0.05),
              _descriptionForm(),
              SizedBox(height: Get.height * 0.05),
              _dateContainer(),
              SizedBox(height: Get.height * 0.05),
              _amountForm(),
              SizedBox(height: Get.height * 0.05),
              _elevatedButtonBuild(),
              SizedBox(height: Get.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  // SizedBox _categorySelectBox() {
  //   return SizedBox(
  //       height: Get.height * 0.13,
  //       width: Get.width,
  //       child: DropdownButtonFormField(
  //         //value: 'ali',
  //         hint: Text('Kategori Seçin',
  //             style: AppKeysTextStyle.buttonTextStyle
  //                 .copyWith(color: AppColors.blackHowl)),
  //         decoration: InputDecoration(
  //             errorBorder: InputBorder.none,
  //             fillColor: Colors.white,
  //             filled: true,
  //             enabledBorder: _formBorder(),
  //             //border: _formBorder(),
  //             focusedBorder: _formBorder()),
  //         style: AppKeysTextStyle.categoryTextStyle,
  //         borderRadius: BorderRadius.circular(15.0),
  //         items: generateDropDownMenuItemList(),
  //         validator: (value) {
  //           if (value == null) {
  //             return AppKeys.categoryFormValidatorText;
  //           }
  //         },
  //         onSaved: (newValue) {
  //           inputController.setCategoryText(newValue);
  //         },
  //         onChanged: (value) {
  //           //categoryController.selectCategory(value);
  //           inputController.selectCategory(value);
  //         },
  //       ));
  // }

  List<DropdownMenuItem<String>> generateDropDownMenuItemList() {
    List<DropdownMenuItem<String>> dropDownMenuItems = [];
    if (inputController.isRemove) {
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

  Column _dateContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(AppKeys.dateText,
              style: AppKeysTextStyle.amountDetailHeaderTextStyle),
        ),
        Container(
          width: Get.width,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat.yMd().format(amount.dateTime),
                      style: AppKeysTextStyle.categoryTextStyle),
                  SizedBox(height: Get.height * 0.01),
                  Text(DateFormat.Hm().format(amount.dateTime),
                      style: AppKeysTextStyle.categoryTextStyle
                          .copyWith(fontSize: Get.width * 0.05))
                ],
              ),
            ),
          ),
          decoration: _boxDecoration(),
        )
      ],
    );
  }

  Align _elevatedButtonBuild() {
    return Align(
        alignment: Alignment.center,
        child: SizedBox(
            height: Get.height * 0.07,
            width: Get.width / 2,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(AppKeys.updateText,
                  style: AppKeysTextStyle.amountDetailHeaderTextStyle
                      .copyWith(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 0.0,
                primary: AppColors.enchantingSapphire,
              ),
            )));
  }

  Column _amountForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            amount.amount >= 0 ? AppKeys.incomeText : AppKeys.expense,
            style: AppKeysTextStyle.amountDetailHeaderTextStyle,
          ),
        ),
        TextFormField(
          initialValue: amount.amount.toString(),
          cursorColor: AppColors.blackHowl,
          decoration: _formInputDecoration(''),
        ),
      ],
    );
  }

  Column _descriptionForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            AppKeys.description,
            style: AppKeysTextStyle.amountDetailHeaderTextStyle,
          ),
        ),
        TextFormField(
          initialValue: amount.description,
          maxLength: 30,
          cursorColor: AppColors.blackHowl,
          decoration: _formInputDecoration(''),
        ),
      ],
    );
  }

  Column _categoryEdit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            AppKeys.categoryHeader,
            style: AppKeysTextStyle.amountDetailHeaderTextStyle,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: Get.height * 0.1,
            width: Get.width,
            decoration: _boxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 9),
                Text(amount.category,
                    style: AppKeysTextStyle.categoryTextStyle),
                const Spacer(flex: 9),
                Icon(Icons.edit, color: AppColors.sparkyBlue),
                const Spacer(flex: 1)
              ],
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(15.0), color: Colors.white);
  }

  InputDecoration _formInputDecoration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        suffixIcon: Icon(Icons.edit, color: AppColors.sparkyBlue),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: _formBorder(),
        //border: _formBorder(),
        focusedBorder: _formBorder(),
        errorBorder: InputBorder.none);
  }

  OutlineInputBorder _formBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white, width: 0.0),
    );
  }
}
