import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasa/controllers/amount_controller.dart';
import 'package:kasa/controllers/bottom_sheet_controller.dart';
import 'package:kasa/controllers/category_controller.dart';
import 'package:kasa/core/constrants/app_colors.dart';
import 'package:kasa/core/constrants/app_keys.dart';
import 'package:kasa/core/constrants/app_keys_textstyle.dart';
import 'package:kasa/data/models/amount.dart';
import 'package:kasa/data/provider/amount_provider.dart';

class BottomSheetWidget extends StatefulWidget {
  BottomSheetWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final BottomSheetController sheetController = Get.find();

  final CategoryController categoryController = Get.find();

  final AmountController amountController = Get.find();

  final key = GlobalKey<FormState>();

  AmountOperations amountOperations = AmountOperations();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomSheetController>(builder: (context) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          height: Get.height * 0.8,
          width: Get.width,
          decoration: BoxDecoration(
              color: AppColors.bakeryBox,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0))),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bottomSheetCancelButton(),
                    SizedBox(height: Get.height * 0.05),
                    _buttonRow(),
                    SizedBox(height: Get.height * 0.03),
                    _categorySelectBox(),
                    SizedBox(height: Get.height * 0.03),
                    _descriptionForm(),
                    SizedBox(height: Get.height * 0.03),
                    _amountFormField(),
                    SizedBox(height: Get.height * 0.01),
                    _saveButton(),
                  ],
                ),
              )),
        ),
      );
    });
  }

  Align _saveButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(elevation: 0.0),
          onPressed: () {
            validateAndSave();
          },
          child: Text(AppKeys.saveText)),
    );
  }

  validateAndSave() async {
    final _isValid = key.currentState!.validate();
    if (_isValid) {
      key.currentState!.save();
      await amountOperations.createAmount(Amount(
          category: sheetController.selectedCategoryText,
          description: sheetController.selectedCategoryText,
          amount: sheetController.amountDouble,
          isFixed: sheetController.isFixedChoosen,
          dateTime: DateTime.now()));
      amountController.getAmountList();
      Get.back();
    }
  }

  SizedBox _amountFormField() {
    return SizedBox(
      height: Get.height * 0.1,
      width: Get.width,
      child: TextFormField(
        keyboardType: TextInputType.number,
        cursorColor: AppColors.blackHowl,
        maxLines: 1,
        textInputAction: TextInputAction.done,
        decoration: _formInputDecoration(
            sheetController.isRemove ? AppKeys.expense : AppKeys.incomeText),
        onSaved: (newValue) {
          sheetController.setAmount(newValue);
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Lütfen bir değer giriniz';
          }
          if (value.isNotEmpty) {
            if (sheetController.isRemove && double.parse(value) < 0) {
              return 'Lütfen 0 dan büyük bir değer giriniz';
            }
          }
        },
      ),
    );
  }

  TextFormField _descriptionForm() {
    return TextFormField(
      cursorColor: AppColors.blackHowl,
      // style: AppKeysTextStyle.buttonTextStyle
      //     .copyWith(color: AppColors.blackHowl),
      validator: (value) {
        if (value!.length > 30) {
          return 'Lütfen 30 karakterden fazla metin girmeyiniz';
        }
      },
      onSaved: (newValue) {
        sheetController.setDescriptionText(newValue);
      },
      textInputAction: TextInputAction.done,
      maxLines: 4,
      maxLength: 30,
      decoration: _formInputDecoration(AppKeys.description),
    );
  }

  InputDecoration _formInputDecoration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        enabledBorder: _formBorder(),
        //border: _formBorder(),
        focusedBorder: _formBorder(),
        errorBorder: InputBorder.none);
  }

  SizedBox _categorySelectBox() {
    return SizedBox(
        height: Get.height * 0.13,
        width: Get.width,
        child: DropdownButtonFormField(
          hint: Text('Kategori Seçin',
              style: AppKeysTextStyle.buttonTextStyle
                  .copyWith(color: AppColors.blackHowl)),
          decoration: InputDecoration(
              errorBorder: InputBorder.none,
              fillColor: Colors.white,
              filled: true,
              enabledBorder: _formBorder(),
              //border: _formBorder(),
              focusedBorder: _formBorder()),
          style: AppKeysTextStyle.dropDownMenuItemTextStyle,
          borderRadius: BorderRadius.circular(15.0),
          items: generateDropDownMenuItemList(),
          validator: (value) {
            if (value == null) {
              return AppKeys.categoryFormValidatorText;
            }
          },
          onSaved: (newValue) {
            sheetController.setCategoryText(newValue);
          },
          onChanged: (value) {
            categoryController.selectCategory(value);
          },
        ));
  }

  OutlineInputBorder _formBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white, width: 0.0),
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
