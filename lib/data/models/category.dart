final String tableCategory = 'category';

class CategoryFields {
  static final List<String> values = [id, category, isIncome];

  static const String id = '_id';
  static const String category = 'category';
  static const String isIncome = 'isIncome';
}

class Category {
  int? id;
  String category;
  bool isIncome;

  Category({this.id, required this.category, required this.isIncome});

  Category copy({int? id, String? category, bool? isIncome}) => Category(
      id: id ?? this.id,
      category: category ?? this.category,
      isIncome: isIncome ?? this.isIncome);

  static Category fromJson(Map<String, Object?> json) => Category(
      id: json[CategoryFields.id] as int?,
      category: json[CategoryFields.category] as String,
      isIncome: json[CategoryFields.isIncome] == 1);

  Map<String, Object?> toJson() => {
        CategoryFields.id: id,
        CategoryFields.category: category,
        CategoryFields.isIncome: isIncome ? 1 : 0
      };
}
