// import 'package:kasa/data/database.dart';
// import 'package:kasa/data/models/period.dart';

// class PeriodOperations {
//   DatabaseRepository dbRepository = DatabaseRepository.instance;

//   Future<Period> createPeriod(Period period) async {
//     final db = await dbRepository.database;

//     final id = await db.insert(tablePeriod, period.toJson());
//     return period.copy(id: id);
//   }

//   Future<int> updatePeriod(Period period) async {
//     final db = await dbRepository.database;

//     return db.update(
//       tablePeriod,
//       period.toJson(),
//       where: '${PeriodFields.id} = ?',
//       whereArgs: [period.id],
//     );
//   }

//   Future<Period> getPeriodByAmountId(int? amountId) async {
//     final db = await dbRepository.database;

//     const where = '${PeriodFields.amountId} = ?';

//     var whereArgs = [amountId];

//     final result =
//         await db.query(tablePeriod, where: where, whereArgs: whereArgs);

//     return result.map((json) => Period.fromJson(json)).toList().first;
//   }
// }
