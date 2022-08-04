import 'package:get/get.dart';

class BottomSheetController extends GetxController {
  final RxBool _isFixedChoosen = false.obs;
  final RxBool _isRemove = false.obs;
  final RxString _selectedCategoryText = ''.obs;
  final RxString _descriptionText = ''.obs;
  final RxDouble _amountDouble = 0.0.obs;

  bool get isFixedChoosen => _isFixedChoosen.value;
  bool get isRemove => _isRemove.value;
  String get selectedCategoryText => _selectedCategoryText.value;
  String get descriptionText => _descriptionText.value;
  double get amountDouble => _amountDouble.value;

  setCategoryText(Object? selectedText) {
    if (selectedText != null) {
      _selectedCategoryText.value = selectedText as String;
      update();
    }
  }

  setDescriptionText(String? descriptionFormText) {
    if (descriptionFormText!.isNotEmpty) {
      _descriptionText.value = descriptionFormText;
      update();
    }
  }

  setAmount(String? formAmount) {
    if (formAmount!.isNotEmpty) {
      _amountDouble.value = double.tryParse(formAmount)!;
      update();
    }
  }

  fixedButtonFunc() {
    _isFixedChoosen.value = true;
    update();
  }

  extraButtonFunc() {
    _isFixedChoosen.value = false;
    update();
  }

  isRemoveFunc(bool isRemoveF) {
    _isRemove.value = isRemoveF;
    update();
  }
}
