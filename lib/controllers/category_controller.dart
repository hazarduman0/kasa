import 'package:get/get.dart';
import 'package:kasa/core/utils.dart';
import 'package:kasa/data/models/category.dart';
import 'package:kasa/data/provider/category_provider.dart';

class CategoryController extends GetxController {
  CategoryOperations categoryOperations = CategoryOperations();

  // final RxList<Category> _expenseCategoryList = <Category>[].obs;
  // final RxList<Category> _incomeCategoryList = <Category>[].obs;
  final RxList<String> _expenseCategoryList = <String>[].obs;
  final RxList<String> _incomeCategoryList = <String>[].obs;
  final RxList<Category> _categoryList = <Category>[].obs;
  final RxString _selectedCategory = ''.obs;

  String get selectedCategory => _selectedCategory.value;
  List<Category> get categoryList => _categoryList;
  // List<Category> get incomeList =>
  //     _categoryList.where((category) => category.isIncome).toList();
  // List<Category> get expenseList =>
  //     _categoryList.where((category) => !category.isIncome).toList();
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
    print('category: ${categoryResponse[5].category}');
    // categoryResponse.where((category) => Utils.whichCategory(
    //     category, _expenseCategoryList, _incomeCategoryList));
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


  void selectCategory(Object? select) {
    _selectedCategory.value = select as String;
    update();
  }
}