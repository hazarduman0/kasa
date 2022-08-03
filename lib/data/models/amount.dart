final String tableAmount = 'amounts';

class AmountFields {
  static final List<String> values = [
    id,
    category,
    description,
    amount,
    isFixed,
    dateTime
  ];

  static const String id = '_id';
  static const String category = 'category';
  static const String description = 'description';
  static const String amount = 'amount';
  static const String isFixed = 'isFixed';
  static const String dateTime = 'dateTime';
}

class Amount {
  int? id;
  String category;
  String description;
  double amount;
  bool isFixed;
  DateTime dateTime;

  Amount(
      {this.id,
      required this.category,
      required this.description,
      required this.amount,
      required this.isFixed,
      required this.dateTime});

  Amount copy(
          {int? id,
          String? category,
          String? description,
          double? amount,
          bool? isFixed,
          DateTime? dateTime}) =>
      Amount(
        id: id ?? this.id,
        category: category ?? this.category,
        description: description ?? this.description,
        amount: amount ?? this.amount,
        isFixed: isFixed ?? this.isFixed,
        dateTime: dateTime ?? this.dateTime,
      );

  static Amount fromJson(Map<String, Object?> json) => Amount(
        id: json[AmountFields.id] as int?,
        category: json[AmountFields.category] as String,
        description: json[AmountFields.description] as String,
        amount: json[AmountFields.amount] as double,
        isFixed: json[AmountFields.isFixed] == 1,
        dateTime: DateTime.parse(json[AmountFields.dateTime] as String),
      );

  Map<String, Object?> toJson() => {
    AmountFields.id : id,
    AmountFields.category : category,
    AmountFields.description : description,
    AmountFields.amount : amount,
    AmountFields.isFixed : isFixed ? 1 : 0,
    AmountFields.dateTime : dateTime.toIso8601String(),
  };   
}
