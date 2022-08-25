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

  final RxBool _isRemove = false.obs;
  final RxBool _editStackBool = false.obs;
  final RxBool _isFixed = false.obs;
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

  bool get isPeriodRemoved => _isPeriodRemoved.value;
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

  setTempAmount(Amount amount) {
    _tempAmount.value = amount;
    update();
  }

  updatePeriod(Amount? amount) {
    if (amount != null) {
      amountOperations.updateAmount(amount);
      _tempAmount.value = amount;
      update();
    }
  }

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
    update();
  }

  setFrequency() {
    _frequency.value = Duration(
        days: _dayPeriod.value,
        hours: _hourPeriod.value,
        minutes: _minutePeriod.value);
    update();
  }


  insertDataByFrequency(Amount amount) async {
    final timeDifference =
        _lastPeriodDate.value!.difference(DateTime.now()).inMinutes;
    final loopInt = timeDifference ~/ Utils.byMinutes(_choosenTimePeriod.value);
    var tempDate = amount.dateTime;

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

  isRemoveFunc(bool isRemoveF) {
    _isRemove.value = isRemoveF;
    update();
  }
}
