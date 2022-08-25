import 'package:get/get.dart';
import 'package:kasa/data/models/category.dart';
import 'package:kasa/data/provider/category_provider.dart';

class CategoryController extends GetxController {
  CategoryOperations categoryOperations = CategoryOperations();

  final RxList<String> _expenseCategoryList = <String>[].obs;
  final RxList<String> _incomeCategoryList = <String>[].obs;
  final RxString _selectedCategory = ''.obs;

  String get selectedCategory => _selectedCategory.value;
  List<String> get incomeList => _incomeCategoryList;
  List<String> get expenseList => _expenseCategoryList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCategoryList();
  }

  getCategoryList() async {
    List<Category> categoryResponse =
        await categoryOperations.getCategoryList();
    getIncomeExpenseList(categoryResponse);
    update();
  }

  getIncomeExpenseList(List<Category> categoryResponse){
    List<String> fIncomeList = [];
    List<String> fExpenseList = [];
    for(var category in categoryResponse){
      if(category.isIncome){
        fIncomeList.add(category.category);
      }else{
        fExpenseList.add(category.category);
      }
    }
    _incomeCategoryList.value = fIncomeList;
    _expenseCategoryList.value = fExpenseList;
    update();
  }
}
