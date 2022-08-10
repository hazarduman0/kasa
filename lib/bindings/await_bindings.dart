import 'dart:developer';

import 'package:get/get.dart';
import 'package:kasa/controllers/amount_controller.dart';
import 'package:kasa/controllers/chart_controller.dart';
import 'package:kasa/controllers/income_expense_controller.dart';
import 'package:kasa/controllers/input_controller.dart';
import 'package:kasa/controllers/category_controller.dart';

class AwaitBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    
    await Get.putAsync(() async => CategoryController(), permanent: true);
    await Get.putAsync(() async => AmountController(), permanent: true);
    await Get.putAsync(() async => InputController(), permanent: true);
    await Get.putAsync(() async=> IncomeExpenseController(), permanent: true);
    //await Get.putAsync(() async => ChartController(), permanent: true);
  }
}
