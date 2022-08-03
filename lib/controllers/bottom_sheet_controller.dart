import 'package:get/get.dart';

class BottomSheetController extends GetxController{
  final RxBool _isFixedChoosen = false.obs;
  final RxBool _isRemove = false.obs;
  

  bool get isFixedChoosen =>  _isFixedChoosen.value;
  bool get isRemove => _isRemove.value;

  fixedButtonFunc(){
    _isFixedChoosen.value = true;
    update();
  }

  extraButtonFunc(){
    _isFixedChoosen.value = false;
    update();
  }

  isRemoveFunc(bool isRemoveF){
    _isRemove.value = isRemoveF;
    update();
  }
}