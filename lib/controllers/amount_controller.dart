
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasa/core/constrants/app_colors.dart';

import 'package:kasa/core/utils.dart';
import 'package:kasa/data/models/amount.dart';
import 'package:kasa/data/provider/amount_provider.dart';

class AmountController extends GetxController {
  AmountOperations amountOperations = AmountOperations();

  final RxList<Amount> _amountList = <Amount>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _pieLoad = false.obs;
  final RxString _selectedRange = 'Son 15 gün'.obs;
  final RxBool _rangeCrossFadeBool = false.obs;
  final RxDouble _netAmount = 0.0.obs;
  final RxDouble _incomeAmount = 0.0.obs;
  final RxDouble _expenseAmount = 0.0.obs;
  final RxList<PieChartSectionData> _getSections = <PieChartSectionData>[].obs;
  // final RxList<charts.Series<Task, String>> _seriesPieData =
  //     <charts.Series<Task, String>>[].obs;

  List<PieChartSectionData> get getSections => _getSections;
  List<Amount> get amountList => _amountList;
  //List<charts.Series<Task, String>> get seriesPieData => _seriesPieData;
  String get selectedRange => _selectedRange.value;
  double get netAmount => _netAmount.value;
  double get incomeAmount => _incomeAmount.value;
  double get expenseAmount => _expenseAmount.value;
  bool get pieLoad => _pieLoad.value;
  bool get isLoading => _isLoading.value;
  bool get rangeCrossFadeBool => _rangeCrossFadeBool.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //getAmountListc();
    getAmountList();
    

    //print('deneme: ${amountOperations.deneme()}');
  }

  @override
  void onReady() {
    super.onReady();
    getPieData();
  }


  // getAmountListc() async {

  //   List<Amount> amountResponse = await amountOperations.getAmountList();
  //   for(var amount in amountResponse){
  //     print(amount.dateTime);
  //   }

  // }

  getAmountList() async {
    String now = '${DateTime.now()}';
    String input =
        '${(DateTime.now()).subtract(Utils.timeAgoFunc(_selectedRange.value))}';

    String timeago = '${input.substring(0, 10)}T${input.substring(11)}';
    String currentTime = '${now.substring(0, 10)}T${now.substring(11)}}';
    _isLoading.value = true;
    update();
    List<Amount> amountResponse = await amountOperations.getDesignatedList(
        timeago: timeago, date: currentTime);

    _amountList.value = amountResponse;
    _isLoading.value = false;
    update();
    setNetAmount(amountResponse);
  }

  getPieData() {
    _pieLoad.value = true;
    update();

    var pieData = [
      Data(
          profitText: 'Gelir',
          profit: 1200,//_incomeAmount.value,
          color: AppColors.limonana),
      Data(
          profitText: 'Gider',
          profit: 400,//_expenseAmount.value,
          color: AppColors.silkenRuby)
    ];

    _getSections.assignAll(pieData
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final value = PieChartSectionData(
              color: data.color, value: data.profit.abs(), title: data.profitText);

          return MapEntry(index, value);
        })
        .values
        .toList());

    // _seriesPieData.assign(charts.Series(
    //   data: pieData,
    //   domainFn: (Task task, _) => task.profitText,
    //   measureFn: (Task task, _) => task.profit.abs(),
    //   colorFn: (Task task, _) => charts.ColorUtil.fromDartColor(task.color),
    //   id: 'Gelir Gider',
    //   //
    // ));

    _pieLoad.value = false;
    update();
  }

  setNetAmount(List<Amount> amountList) {
    double net = 0.0;
    double expense = 0.0;
    double income = 0.0;
    for (var amount in amountList) {
      net = net + (amount.amount);
      if (amount.amount < 0) {
        expense = expense + amount.amount;
      } else {
        income = income + amount.amount;
      }
    }
    _netAmount.value = net;
    _incomeAmount.value = income;
    _expenseAmount.value = expense;
    update();
  }

  // getAmountList() async {
  //   _isLoading.value = true;
  //   update();
  //   List<Amount> amountResponse = await amountOperations.getAmountList();
  //   _amountList.value = amountResponse;
  //   _isLoading.value = false;
  //   update();
  // }

  setSelectedRange(String range) {
    _selectedRange.value = range;
    update();
  }

  setRangeCrossFadeBool(bool crossFadeBool) {
    _rangeCrossFadeBool.value = crossFadeBool;
    update();
  }
}

class Data {
  String profitText;
  double profit;
  Color color;
  Data({
    required this.profitText,
    required this.profit,
    required this.color,
  });
}
