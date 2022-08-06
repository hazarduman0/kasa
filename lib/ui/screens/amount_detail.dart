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

class AmountDetailPage extends StatelessWidget {
  AmountDetailPage({Key? key, required this.amount}) : super(key: key);

  Amount amount;

  final InputController inputController = Get.find();

  final CategoryController categoryController = Get.find();

  final AmountController amountController = Get.find();

  AmountOperations amountOperations = AmountOperations();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('amountDate: ${amount.dateTime}');
    print(DateTime.now());
    print('1 hours ago: ${( DateTime.now()).subtract( const Duration(days: 7))}');
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
                          amountOperations.deleteAmount(amount.id);
                          amountController.getAmountList(); //controllere yaptır
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
              onPressed: () {
                validateAndUpdate();
              },
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

  validateAndUpdate() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      amountOperations.updateAmount(Amount(
          id: amount.id,
          category: inputController.selectedCategoryText,
          description: inputController.descriptionText,
          amount: inputController.amountDouble,
          isFixed: amount.isFixed,
          dateTime: amount.dateTime));
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
            amount.amount >= 0 ? AppKeys.incomeText : AppKeys.expense,
            style: AppKeysTextStyle.amountDetailHeaderTextStyle,
          ),
        ),
        TextFormField(
          initialValue: amount.amount.toString(),
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
          initialValue: amount.description,
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
