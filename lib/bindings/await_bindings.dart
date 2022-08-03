import 'package:get/get.dart';
import 'package:kasa/controllers/bottom_sheet_controller.dart';
import 'package:kasa/controllers/category_controller.dart';

class AwaitBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync(() async => BottomSheetController(), permanent: true);
    await Get.putAsync(() async => CategoryController(), permanent: true);
  }
}
