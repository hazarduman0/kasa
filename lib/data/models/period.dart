final String tablePeriod = 'period';

class PeriodFields {
  static final List<String> values = [];

  static const String id = '_id';
  static const String amountId = 'amountId';
  static const String duration = 'duration';
}

class Period {
  int? id;
  int amountId;
  String duration;

  Period({this.id, required this.amountId, required this.duration});

  Period copy({int? id, int? amountId, String? duration}) => Period(
      id: id ?? this.id,
      amountId: amountId ?? this.amountId,
      duration: duration ?? this.duration);

  static Period fromJson(Map<String, Object?> json) => Period(
      id: json[PeriodFields.id] as int?,
      amountId: json[PeriodFields.amountId] as int,
      duration: json[PeriodFields.duration] as String);

  Map<String, Object?> toJson() => {
        PeriodFields.id: id,
        PeriodFields.amountId: amountId,
        PeriodFields.duration: duration,
      };
}
