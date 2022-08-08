import 'package:kasa/data/database.dart';
import 'package:kasa/data/models/amount.dart';

class AmountOperations {
  DatabaseRepository dbRepository = DatabaseRepository.instance;

  //create
  //read
  //update
  //delete

  Future<Amount> createAmount(Amount amount) async {
    final db = await dbRepository.database;

    final id = await db.insert(tableAmount, amount.toJson());
    return amount.copy(id: id);
  }

  // Future<List<Amount>> insertDataByFrequency(List<Amount> amountList, /*Duration frequency, DateTime periodEndDate*/) async {
  //   final db = await dbRepository.database;

  //   List<Amount> tempAmountList = [];

  //   for(var amount in amountList){
  //     final id = await db.insert(tableAmount, amount.toJson());
  //     tempAmountList.add(amount.copy(id: id));
  //   }
  //   return tempAmountList;
  // }

  Future<int> updateAmount(Amount amount) async {
    final db = await dbRepository.database;

    return db.update(
      tableAmount,
      amount.toJson(),
      where: '${AmountFields.id} = ?',
      whereArgs: [amount.id],
    );
  }

  Future<int> deleteAmount(int? id) async {
    final db = await dbRepository.database;

    return await db.delete(
      tableAmount,
      where: '${AmountFields.id} = ?',
      whereArgs: [id],
    );
  }

  // Future<List<Amount>> deneme() async {
  //   final db = await dbRepository.database;

  //   // const orderBy = '${AmountFields.dateTime} DESC';

  //   // const where = '2022-08-05 21:30:48.913092 ';

  //   final result = await db.rawQuery(
  //       '''SELECT * FROM $tableAmount WHERE ${AmountFields.dateTime} BETWEEN '2022-08-05T21:30:48.913092' AND '${DateTime.now()}' ORDER BY ${AmountFields.dateTime} DESC ''');

  //   return result.map((json) => Amount.fromJson(json)).toList();
  // }

  Future<List<Amount>> getDesignatedList(
      {required String timeago, required String date}) async {
    final db = await dbRepository.database;

    const orderBy = '${AmountFields.dateTime} DESC';

    const where = AmountFields.dateTime;

    final result = await db.rawQuery(
        '''SELECT * FROM $tableAmount WHERE $where BETWEEN '$timeago' AND '$date' ORDER BY $orderBy ''');

    return result.map((json) => Amount.fromJson(json)).toList();
  }



  // Future<List<Amount>> getAmountList() async {
  //   final db = await dbRepository.database;

  //   const orderBy = '${AmountFields.dateTime} DESC';

  //   final result = await db.query(
  //     tableAmount,
  //     orderBy: orderBy,
  //   );

  //   return result.map((json) => Amount.fromJson(json)).toList();
  // }
}
