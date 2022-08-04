import 'package:get/get.dart';
import 'package:kasa/data/models/amount.dart';
import 'package:kasa/data/provider/amount_provider.dart';

class AmountController extends GetxController {
  AmountOperations amountOperations = AmountOperations();

  final RxList<Amount> _amountList = <Amount>[].obs;

  List<Amount> get amountList => _amountList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAmountList();
  }

  getAmountList() async {
    List<Amount> amountResponse = await amountOperations.getAmountList();
    _amountList.value = amountResponse;
    update();
  }
}
