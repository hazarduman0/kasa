import 'dart:developer';

import 'package:get/get.dart';
import 'package:kasa/controllers/amount_controller.dart';
import 'package:kasa/controllers/input_controller.dart';
import 'package:kasa/controllers/category_controller.dart';

class AwaitBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    
    await Get.putAsync(() async => CategoryController(), permanent: true);
    log("1");
    log("2");
    log("3");
    await Get.putAsync(() async => AmountController(), permanent: true);
    log("4");
    await Get.putAsync(() async => InputController(), permanent: true);
  }
}
