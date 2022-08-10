import 'dart:developer';

import 'package:kasa/data/database.dart';
import 'package:kasa/data/models/amount.dart';

class AmountOperations {
  DatabaseRepository dbRepository = DatabaseRepository.instance;
  // PeriodOperations periodOperations = PeriodOperations();
  
  // final box = GetStorage();

  //create
  //read
  //update
  //delete

  Future<Amount> createAmount(Amount amount) async {
    final db = await dbRepository.database;

    final id = await db.insert(tableAmount, amount.toJson());

    // if (amount.isFixed) {
    //   await periodOperations.createPeriod(
    //       Period(amountId: id, duration: box.read('period')));
    // }
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

  Future<int?> getIdByDate(String date) async {
    final db = await dbRepository.database;

    final result = await db.query(
      tableAmount,
      where: '${AmountFields.dateTime} = ?',
      whereArgs: [date]
    );

    var resultList = result.map((json) => Amount.fromJson(json)).toList();
    if(resultList.isEmpty) return null;
    return resultList.first.id;
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

  Future<List<Amount>> getFixedIncomeList() async {
    try {
      final db = await dbRepository.database;

    const orderBy = '${AmountFields.dateTime} DESC';

    const where = '${AmountFields.isFirst} = ?';

    var whereArgs = [1];

    final result = await db.query(
      tableAmount,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy
    );

    var resultList = result.map((json) => Amount.fromJson(json)).toList();

    List<Amount> fixedIncomeList = resultList.where((e) => e.amount >= 0 ).toList(); 

    return fixedIncomeList;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<Amount>> getFixedExpenseList() async {
    final db = await dbRepository.database;

    const orderBy = '${AmountFields.dateTime} DESC';

    const where = '${AmountFields.isFirst} = ?';

    var whereArgs = [1];

    final result = await db.query(
      tableAmount,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy
    );

    var resultList = result.map((json) => Amount.fromJson(json)).toList();

    List<Amount> fixedExpenseList = resultList.where((e) => e.amount < 0 ).toList(); 

    return fixedExpenseList;
  }

  Future<List<Amount>> getRegularIncomeList() async {
    final db = await dbRepository.database;

    const orderBy = '${AmountFields.dateTime} DESC';

    const where = '${AmountFields.isFixed} = ?';

    var whereArgs = [0];

    final result = await db.query(
      tableAmount,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy
    );

    var resultList = result.map((json) => Amount.fromJson(json)).toList();

    List<Amount> regularIncomeList = resultList.where((e) => e.amount >= 0 ).toList(); 

    return regularIncomeList;
  }

  Future<List<Amount>> getRegularExpenseList() async {
    final db = await dbRepository.database;

    const orderBy = '${AmountFields.dateTime} DESC';

    const where = '${AmountFields.isFixed} = ?';

    var whereArgs = [0];

    final result = await db.query(
      tableAmount,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy
    );

    var resultList = result.map((json) => Amount.fromJson(json)).toList();

    List<Amount> regularExpenseList = resultList.where((e) => e.amount < 0 ).toList(); 

    return regularExpenseList;
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
