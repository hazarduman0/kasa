import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasa/controllers/amount_controller.dart';
import 'package:kasa/controllers/input_controller.dart';
import 'package:kasa/controllers/category_controller.dart';
import 'package:kasa/core/constrants/app_colors.dart';
import 'package:kasa/core/constrants/app_keys.dart';
import 'package:kasa/core/constrants/app_keys_textstyle.dart';
import 'package:kasa/data/models/amount.dart';
import 'package:kasa/data/provider/amount_provider.dart';

import 'package:kasa/ui/widgets/home/period_select_gridview.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final InputController inputController = Get.find();

  final CategoryController categoryController = Get.find();

  final AmountController amountController = Get.find();

  final key = GlobalKey<FormState>();

  AmountOperations amountOperations = AmountOperations();

  DateTime tempDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.8,
      width: Get.width,
      decoration: BoxDecoration(
          color: AppColors.bakeryBox,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bottomSheetCancelButton(),
                  SizedBox(height: Get.height * 0.05),
                  _categorySelectBox(),
                  SizedBox(height: Get.height * 0.03),
                  _descriptionForm(),
                  SizedBox(height: Get.height * 0.03),
                  _amountFormField(),
                  SizedBox(height: Get.height * 0.03),
                  _fixedTimePicker(),
                  SizedBox(height: Get.height * 0.01),
                  _saveButton(),
                ],
              ),
            )),
      ),
    );
  }

  GetBuilder _fixedTimePicker() {
    return GetBuilder<InputController>(builder: (input) {
      return AnimatedContainer(
        width: Get.width,
        constraints: BoxConstraints(minHeight: Get.height * 0.1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        duration: const Duration(milliseconds: 150),
        child: !input.isFixed
            ? Center(child: _checkboxListTile())
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _checkboxListTile(),
                    const Divider(),
                    _selectPeriodText(),
                    const PeriodGridView(),
                    const Divider(),
                    _lasPeriodDateText(),
                    _lastPeriodDate(),
                  ],
                ),
              ),
      );
    });
  }

  Padding _lasPeriodDateText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${AppKeys.lastPeriodDate}:'),
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: '',
                    middleText:
                        'Seçilmiş olan tekrarlanma periyotların son tarihi belirlenir. Bu tarihten sonra periyodik olarak ekleme işlemi sona erer.',
                    textCancel: 'Tamam',
                    buttonColor: Colors.white);
              },
              icon: const Icon(Icons.info_outlined, color: Colors.grey))
        ],
      ),
    );
  }

  SizedBox _lastPeriodDate() {
    return SizedBox(
      height: Get.height * 0.25,
      width: Get.width,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        minimumYear: DateTime.now().year,
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (value) {
          print('dateTime: $value');
          tempDateTime =
              value; 
        },
      ),
    );
  }

  Padding _selectPeriodText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${AppKeys.frequencyRecurrence}:'),
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: '',
                    middleText:
                        'Seçtiğiniz tekrarlanma ölçütüne göre belirlenmiş gelir giderler periyodik olarak eklenirler.',
                    textCancel: 'Tamam',
                    buttonColor: Colors.white);
              },
              icon: const Icon(Icons.info_outlined, color: Colors.grey))
        ],
      ),
    );
  }

  GetBuilder _checkboxListTile() {
    return GetBuilder<InputController>(builder: (input) {
      return CheckboxListTile(
        title: const Text('Sabit'),
        value: input.isFixed,
        onChanged: (value) {
          input.setIsFixed(value!);
        },
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
      if (inputController.isFixed) {
        inputController.setLastPeriodDate(tempDateTime);
        inputController.setFrequency();
        inputController.insertDataByFrequency(Amount(
            category: inputController.selectedCategoryText,
            description: inputController.descriptionText,
            amount: inputController.isRemove
                ? (-inputController.amountDouble)
                : inputController.amountDouble,
            isFixed: true,
            dateTime: DateTime.now(),
            period: inputController.choosenTimePeriod,
            isFirst: true
            ));
      } else {
        await amountOperations.createAmount(Amount(
            category: inputController.selectedCategoryText,
            description: inputController.descriptionText,
            amount: inputController.isRemove
                ? (-inputController.amountDouble)
                : inputController.amountDouble,
            isFixed: false,
            dateTime: DateTime.now(),
            isFirst: false
            ));
      }

      amountController.getAmountList();
      inputController.setIsFixed(false);
      Get.back();
    }
  }

  sheetDispose() {}

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
            inputController.isRemove ? AppKeys.expense : AppKeys.incomeText),
        onSaved: (newValue) {
          inputController.setAmount(newValue);
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Lütfen bir değer giriniz';
          }
          if (value.isNotEmpty) {
            if (inputController.isRemove && double.parse(value) < 0) {
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
      validator: (value) {
        if (value!.length > 30) {
          return 'Lütfen 30 karakterden fazla metin girmeyiniz';
        }
      },
      onSaved: (newValue) {
        inputController.setDescriptionText(newValue);
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
              focusedBorder: _formBorder()),
          style: AppKeysTextStyle.categoryTextStyle,
          borderRadius: BorderRadius.circular(15.0),
          items: generateDropDownMenuItemList(),
          validator: (value) {
            if (value == null) {
              return AppKeys.categoryFormValidatorText;
            }
          },
          onSaved: (newValue) {
            inputController.setCategoryText(newValue);
          },
          onChanged: (value) {
            inputController.selectCategory(value);
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
                inputController.setIsFixed(false);
                Get.back();
              },
              child: Text(AppKeys.cancel,
                  style: AppKeysTextStyle.cancelTextStyle)),
        ));
  }

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
}
