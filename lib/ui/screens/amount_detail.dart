import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasa/controllers/amount_controller.dart';
import 'package:kasa/controllers/category_controller.dart';
import 'package:kasa/controllers/input_controller.dart';
import 'package:kasa/core/constrants/app_colors.dart';
import 'package:kasa/core/constrants/app_keys.dart';
import 'package:kasa/core/constrants/app_keys_textstyle.dart';
import 'package:kasa/data/models/amount.dart';
import 'package:kasa/data/provider/amount_provider.dart';
import 'package:kasa/ui/screens/home_page.dart';
import 'package:kasa/ui/widgets/home/period_select_gridview.dart';

class AmountDetailPage extends StatelessWidget {
  AmountDetailPage({Key? key}) : super(key: key);

  //Amount amount;

  final InputController inputController = Get.find();

  final CategoryController categoryController = Get.find();

  final AmountController amountController = Get.find();

  AmountOperations amountOperations = AmountOperations();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputController>(builder: (input) {
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined,
                      color: Colors.black)),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                        titlePadding: const EdgeInsets.all(10.0),
                        contentPadding: const EdgeInsets.all(10.0),
                        textCancel: 'İptal',
                        middleText: 'İşlem silinecek onaylıyor musun?',
                        textConfirm: 'Sil',
                        confirmTextColor: Colors.red,
                        buttonColor: Colors.white,
                        title: 'Silinecek',
                        onConfirm: () {
                          amountOperations.deleteAmount(input.tempAmount!.id);
                          amountController.getAmountList();
                          Get.to(() => HomePage());
                        },
                      );
                    },
                    icon: Icon(Icons.delete, color: AppColors.silkenRuby))
              ],
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _categoryEdit(),
                        SizedBox(height: Get.height * 0.05),
                        _descriptionForm(),
                        SizedBox(height: Get.height * 0.05),
                        _dateContainer(),
                        input.tempAmount!.isFixed
                            ? SizedBox(height: Get.height * 0.05)
                            : const SizedBox.shrink(),
                        input.tempAmount!.isFixed
                            ? _periodInteract()
                            : const SizedBox.shrink(),
                        SizedBox(height: Get.height * 0.05),
                        _amountForm(),
                        SizedBox(height: Get.height * 0.05),
                        _elevatedButtonBuild(),
                        SizedBox(height: Get.height * 0.05),
                      ],
                    ),
                  )),
            ),
          ),
          input.editBool
              ? GestureDetector(
                  onTap: () {
                    input.setEditStackBool(false);
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: Get.height,
                    width: Get.width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.1),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: Get.width * 0.9,
                            child: Card(
                              elevation: 8.0,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: _categoryList(),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                )
              : const SizedBox.shrink()
        ],
      );
    });
  }

  GetBuilder<InputController> _periodInteract() {
    return GetBuilder<InputController>(builder: (input) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Get.defaultDialog(
                  title: 'Periyot kaldırılacak',
                  middleText: 'Periyodu kaldırmak istediğinizden emin misiniz?',
                  textCancel: 'iptal',
                  textConfirm: 'Kaldır',
                  onConfirm: () {
                    input.deleteDataByFrequency(input.tempAmount!);
                    input.updatePeriod(
                        input.tempAmount!.copy(isFixed: false, period: null));
                    Get.back();
                  },
                  confirmTextColor: AppColors.silkenRuby,
                  buttonColor: Colors.white);
            },
            child: const Text('Periyodu kaldır'),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info_outlined, color: Colors.grey)),
            ],
          )
        ],
      );
    });
  }

  GetBuilder _timePeriodGrid(String text) {
    return GetBuilder<InputController>(builder: (input) {
      return Container(
        width: Get.width / 2,
        decoration: BoxDecoration(
            color: input.choosenTimePeriod == text
                ? Colors.blue.shade100
                : Colors.transparent),
        child: Center(
            child: TextButton(
                onPressed: () {
                  input.setChoosenTimePeriod(text);
                },
                child: Text(text))),
      );
    });
  }

  List<Widget> _categoryList() {
    bool listBool = !inputController.isRemove;
    return List.generate(
        listBool
            ? categoryController.incomeList.length
            : categoryController.expenseList.length,
        (index) => _categoryTile(listBool
            ? categoryController.incomeList[index]
            : categoryController.expenseList[index]));
  }

  GestureDetector _categoryTile(String category) {
    return GestureDetector(
      onTap: () {
        inputController.setCategoryText(category);
        inputController.setEditStackBool(false);
      },
      child: ListTile(
        leading: Text(category, style: AppKeysTextStyle.categoryTextStyle),
      ),
    );
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
          decoration: _boxDecoration(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      DateFormat.yMd()
                          .format(inputController.tempAmount!.dateTime),
                      style: AppKeysTextStyle.categoryTextStyle),
                  SizedBox(height: Get.height * 0.01),
                  Text(
                      DateFormat.Hm()
                          .format(inputController.tempAmount!.dateTime),
                      style: AppKeysTextStyle.categoryTextStyle
                          .copyWith(fontSize: Get.width * 0.05))
                ],
              ),
            ),
          ),
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
              onPressed: () {
                validateAndUpdate();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 0.0,
                primary: AppColors.enchantingSapphire,
              ),
              child: Text(AppKeys.updateText,
                  style: AppKeysTextStyle.amountDetailHeaderTextStyle
                      .copyWith(color: Colors.white)),
            )));
  }

  validateAndUpdate() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      amountOperations.updateAmount(Amount(
          id: inputController.tempAmount!.id,
          category: inputController.selectedCategoryText,
          description: inputController.descriptionText,
          amount: inputController.amountDouble,
          isFixed: inputController.tempAmount!.isFixed ? true : false,
          dateTime: inputController.tempAmount!.dateTime,
          period: inputController.tempAmount!.isFixed
              ? inputController.tempAmount!.period
              : null,
          isFirst: inputController.tempAmount!.isFirst 
              ));
      amountController.getAmountList();
      Get.back();
    }
  }

  Column _amountForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            inputController.tempAmount!.amount >= 0
                ? AppKeys.incomeText
                : AppKeys.expense,
            style: AppKeysTextStyle.amountDetailHeaderTextStyle,
          ),
        ),
        TextFormField(
          initialValue: inputController.tempAmount!.amount.toString(),
          cursorColor: AppColors.blackHowl,
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
          initialValue: inputController.tempAmount!.description,
          maxLength: 30,
          cursorColor: AppColors.blackHowl,
          onSaved: (newValue) {
            inputController.setDescriptionText(newValue);
          },
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
          onTap: () {
            inputController.setEditStackBool(true);
          },
          child: Container(
            height: Get.height * 0.1,
            width: Get.width,
            decoration: _boxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 9),
                GetBuilder<InputController>(builder: (input) {
                  return Text(input.selectedCategoryText,
                      style: AppKeysTextStyle.categoryTextStyle);
                }),
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
