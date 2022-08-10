import 'dart:developer';

import 'package:get/get.dart';
import 'package:kasa/core/utils.dart';
import 'package:kasa/data/models/amount.dart';
import 'package:kasa/data/provider/amount_provider.dart';

class InputController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    log("test");
  }

  AmountOperations amountOperations = AmountOperations();

  //final RxBool _isFixedChoosen = false.obs;
  final RxBool _isRemove = false.obs;
  final RxBool _editStackBool = false.obs;
  final RxBool _isFixed = false.obs;
  //final RxBool _isTextButtonPressed = false.obs;
  final RxBool _isPeriodRemoved = false.obs;
  final RxString _selectedCategoryText = ''.obs;
  final RxString _descriptionText = ''.obs;
  final RxDouble _amountDouble = 0.0.obs;
  final RxInt _dayPeriod = 0.obs;
  final RxInt _hourPeriod = 0.obs;
  final RxInt _minutePeriod = 0.obs;
  final Rx<DateTime?> _lastPeriodDate = Rxn();
  final Rx<Duration?> _frequency = Rxn();
  final Rx<Amount?> _tempAmount = Rxn();
  final RxString _choosenTimePeriod = '30 gün'.obs;

  //final RxBool _isValidTimePeriod = true.obs;

  //bool get isFixedChoosen => _isFixedChoosen.value;
  bool get isPeriodRemoved => _isPeriodRemoved.value;
  //bool get isTextButtonPressed => _isTextButtonPressed.value;
  bool get editBool => _editStackBool.value;
  bool get isRemove => _isRemove.value;
  String get selectedCategoryText => _selectedCategoryText.value;
  String get descriptionText => _descriptionText.value;
  String get choosenTimePeriod => _choosenTimePeriod.value;
  double get amountDouble => _amountDouble.value;
  int get dayPeriod => _dayPeriod.value;
  int get hourPeriod => _hourPeriod.value;
  int get minutePeriod => _minutePeriod.value;
  bool get isFixed => _isFixed.value;
  DateTime? get lastPeriodDate => _lastPeriodDate.value;
  Duration? get frequency => _frequency.value;
  Amount? get tempAmount => _tempAmount.value;
  //bool get isValidTimePeriod => _isValidTimePeriod.value;

  setTempAmount(Amount amount) {
    _tempAmount.value = amount;
    update();
  }

  updatePeriod(Amount? amount) {
    //_isPeriodRemoved.value = value;
    if (amount != null) {
      amountOperations.updateAmount(amount);
      _tempAmount.value = amount;
      update();
    }
  }

  // updatePeriod(Amount? amount, String? period) {
  //   //_isPeriodRemoved.value = value;
  //   if (amount == null) return;
  //   if (period != null) {
  //     amountOperations.updateAmount(amount.copy(period: period));
  //   } else {
  //     amountOperations.updateAmount(amount);
  //   }

  //   _tempAmount.value = amount;
  //   update();
  // }

  // setTextButtonPress(bool value) {
  //   _isTextButtonPressed.value = value;
  //   update();
  // }

  setChoosenTimePeriod(String text) {
    _choosenTimePeriod.value = text;
    update();
  }

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
  // oinsertDataByFrequency(Amount amount) async {
  //   //List<Amount> amountList = [];
  //   final timeDifference =
  //       _lastPeriodDate.value!.difference(DateTime.now()).inMinutes;
  //   // print('timeDifference: $timeDifference');
  //   // print('_frequency.value!.inMinutes : ${_frequency.value!.inMinutes}');
  //   final loopInt = timeDifference ~/ _frequency.value!.inMinutes;
  //   var tempDate = DateTime.now();
  //   //print('loopInt : $loopInt');
  //   for (int i = 0; i <= loopInt; i++) {
  //     await amountOperations.createAmount(amount.copy(dateTime: tempDate));
  //     tempDate = tempDate.subtract(Duration(minutes: timeDifference));
  //   }
  // }

  insertDataByFrequency(Amount amount) async {
    final timeDifference =
        _lastPeriodDate.value!.difference(DateTime.now()).inMinutes;
    final loopInt = timeDifference ~/ Utils.byMinutes(_choosenTimePeriod.value);
    var tempDate = amount.dateTime;

    //box.write('period', _choosenTimePeriod.value );

    // if (amount.amount < 0) {
    //   // List<Amount> _fixedExpenseList = box.read('FixedExpense');
    //   // _fixedExpenseList.add(amount);
    //   // box.write('FixedExpense', _fixedExpenseList);
    //   box.write('fixedExpense${amount.id}', amount);
    // } else {
    //   box.write('fixedIncome${amount.id}', amount);
    //   // List<Amount> _fixedIncomeList = box.read('FixedIncome');
    //   // _fixedIncomeList.add(amount);
    //   // box.write('FixedIncome', _fixedIncomeList);
    // }

    await amountOperations.createAmount(amount);

    tempDate = tempDate
        .add(Duration(minutes: Utils.byMinutes(_choosenTimePeriod.value)));

    for (int i = 0; i < loopInt; i++) {
      await amountOperations
          .createAmount(amount.copy(dateTime: tempDate, isFirst: false));
      tempDate = tempDate
          .add(Duration(minutes: Utils.byMinutes(_choosenTimePeriod.value)));
    }
  }

  deleteDataByFrequency(Amount amount) async {
    //if (amount == null) return;

    DateTime dateTime = amount.dateTime;
    Duration duration = Duration(minutes: Utils.byMinutes(amount.period!));

    while (true) {
      String dateString = '${(dateTime).add(duration)}';

      dateTime = dateTime.add(duration);

      String timeFormat =
          '${dateString.substring(0, 10)}T${dateString.substring(11)}';

      var id = await amountOperations.getIdByDate(timeFormat);
      if (id == null) break;
      amountOperations.deleteAmount(id);
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
