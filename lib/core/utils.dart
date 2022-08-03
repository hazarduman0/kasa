import 'package:kasa/data/models/category.dart';

class Utils {
  static whichCategory(
      Category category, List<String> expenseList, List<String> incomeList) {
    if (category.isIncome) {
      expenseList.add(category.category);
    } else {
      incomeList.add(category.category);
    }
  }
}
