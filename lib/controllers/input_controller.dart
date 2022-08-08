import 'package:get/get.dart';
import 'package:kasa/data/models/amount.dart';
import 'package:kasa/data/provider/amount_provider.dart';

class InputController extends GetxController {
  AmountOperations amountOperations = AmountOperations();

  //final RxBool _isFixedChoosen = false.obs;
  final RxBool _isRemove = false.obs;
  final RxBool _editStackBool = false.obs;
  final RxBool _isFixed = false.obs;
  final RxString _selectedCategoryText = ''.obs;
  final RxString _descriptionText = ''.obs;
  final RxDouble _amountDouble = 0.0.obs;
  final RxInt _dayPeriod = 0.obs;
  final RxInt _hourPeriod = 0.obs;
  final RxInt _minutePeriod = 0.obs;
  final Rx<DateTime?> _lastPeriodDate = Rxn();
  final Rx<Duration?> _frequency = Rxn();
  //final RxBool _isValidTimePeriod = true.obs;

  //bool get isFixedChoosen => _isFixedChoosen.value;
  bool get editBool => _editStackBool.value;
  bool get isRemove => _isRemove.value;
  String get selectedCategoryText => _selectedCategoryText.value;
  String get descriptionText => _descriptionText.value;
  double get amountDouble => _amountDouble.value;
  int get dayPeriod => _dayPeriod.value;
  int get hourPeriod => _hourPeriod.value;
  int get minutePeriod => _minutePeriod.value;
  bool get isFixed => _isFixed.value;
  DateTime? get lastPeriodDate => _lastPeriodDate.value;
  Duration? get frequency => _frequency.value;
  //bool get isValidTimePeriod => _isValidTimePeriod.value;

  setCategoryText(Object? selectedText) {
    if (selectedText != null) {
      _selectedCategoryText.value = selectedText as String;
      update();
    }
  }

  setDayPeriod(String? value) {
    if (value != null) {
      _dayPeriod.value = int.parse(value);
      update();
    }
  }

  setHourPeriod(String? value) {
    if (value != null) {
      _hourPeriod.value = int.parse(value);
      update();
    }
  }

  setMinutePeriod(String? value) {
    if (value != null) {
      _minutePeriod.value = int.parse(value);
      update();
    }
  }

  setLastPeriodDate(DateTime? value) {
    _lastPeriodDate.value = value;
    print('controller: ${_lastPeriodDate.value}');
    update();
  }

  setFrequency() {
    _frequency.value = Duration(
        days: _dayPeriod.value,
        hours: _hourPeriod.value,
        minutes: _minutePeriod.value);
    print(_frequency.value);
    print(_dayPeriod.value);
    update();
  }

  ////
  insertDataByFrequency(Amount amount) async {
    //List<Amount> amountList = [];
    final timeDifference =
        _lastPeriodDate.value!.difference(DateTime.now()).inMinutes;
    // print('timeDifference: $timeDifference');
    // print('_frequency.value!.inMinutes : ${_frequency.value!.inMinutes}');
    final loopInt = timeDifference ~/ _frequency.value!.inMinutes;
    var tempDate = DateTime.now();
    //print('loopInt : $loopInt');
    for (int i = 0; i <= loopInt; i++) {
      await amountOperations.createAmount(amount.copy(dateTime: tempDate));
      tempDate = tempDate.subtract(Duration(minutes: timeDifference));
    }
  }

  // setValidTimePeriod(bool value){
  //   _isValidTimePeriod.value = value;
  //   update();
  // }

  setEditStackBool(bool editStack) {
    _editStackBool.value = editStack;
    update();
  }

  setDescriptionText(String? descriptionFormText) {
    _descriptionText.value = descriptionFormText!;
    update();
  }

  setAmount(String? formAmount) {
    if (formAmount!.isNotEmpty) {
      _amountDouble.value = double.tryParse(formAmount)!;
      print(_amountDouble);
      update();
    }
  }

  void selectCategory(Object? select) {
    _selectedCategoryText.value = select as String;
    update();
  }

  setIsFixed(bool value) {
    _isFixed.value = value;
    update();
  }

  // fixedButtonFunc() {
  //   _isFixedChoosen.value = true;
  //   update();
  // }

  // extraButtonFunc() {
  //   _isFixedChoosen.value = false;
  //   update();
  // }

  isRemoveFunc(bool isRemoveF) {
    _isRemove.value = isRemoveF;
    update();
  }
}
