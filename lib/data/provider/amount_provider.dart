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

  Future<List<Amount>> getAmountList () async {
    final db = await dbRepository.database;

    const orderBy = '${AmountFields.category} ASC';

    final result = await db.query(
      tableAmount,
      orderBy: orderBy,
    );

    return result.map((json) => Amount.fromJson(json)).toList();
  }

}
