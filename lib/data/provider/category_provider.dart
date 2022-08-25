import 'package:kasa/data/database.dart';
import 'package:kasa/data/models/category.dart';

class CategoryOperations {
  DatabaseRepository dbRepository = DatabaseRepository.instance;

  Future<Category> createCategory(Category category) async {
    final db = await dbRepository.database;

    final id = await db.insert(tableCategory, category.toJson());
    return category.copy(id: id);
  }

  Future<List<Category>> getCategoryList() async {
    final db = await dbRepository.database;

    final result = await db.query(tableCategory);

    List<Category> categoryList = [];
    var response = result.map((json) => Category.fromJson(json));
    if (response.isNotEmpty) {
      categoryList = response.toList();
    }
    return categoryList;
  }
}
