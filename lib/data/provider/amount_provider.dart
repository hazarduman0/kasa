import 'dart:developer';

import 'package:kasa/data/database.dart';
import 'package:kasa/data/models/amount.dart';

class AmountOperations {
  DatabaseRepository dbRepository = DatabaseRepository.instance;

  Future<Amount> createAmount(Amount amount) async {
    final db = await dbRepository.database;

    final id = await db.insert(tableAmount, amount.toJson());

    return amount.copy(id: id);
  }

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
}
