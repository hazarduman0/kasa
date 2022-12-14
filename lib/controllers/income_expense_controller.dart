import 'package:get/get.dart';
import 'package:kasa/data/models/amount.dart';
import 'package:kasa/data/provider/amount_provider.dart';
class IncomeExpenseController extends GetxController {
  AmountOperations amountOperations = AmountOperations();

  RxList<Amount> _fixedIncomeList = <Amount>[].obs;
  RxList<Amount> _fixedExpenseList = <Amount>[].obs;
  RxList<Amount> _regularIncomeList = <Amount>[].obs;
  RxList<Amount> _regularExpenseList = <Amount>[].obs;

  List<Amount> get fixedIncomeList => _fixedIncomeList.value;
  List<Amount> get fixedExpenseList => _fixedExpenseList.value;
  List<Amount> get regularIncomeList => _regularIncomeList.value;
  List<Amount> get regularExpenseList => _regularExpenseList.value;

  getFixedIncomeList() async {
    _fixedIncomeList.assignAll(await amountOperations.getFixedIncomeList());
    update();
  }

  getFixedExpenseList() async {
    _fixedExpenseList.value = await amountOperations.getFixedExpenseList();
    update();
  }

  getRegularIncomeList() async {
    _regularIncomeList.value = await amountOperations.getRegularIncomeList();
    update();
  }

  getRegularExpenseList() async {
    _regularExpenseList.value = await amountOperations.getRegularExpenseList();
    update();
  }
}
