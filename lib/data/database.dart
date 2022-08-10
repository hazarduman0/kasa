import 'dart:async';

import 'package:kasa/data/models/amount.dart';
import 'package:kasa/data/models/category.dart';
import 'package:kasa/data/models/period.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseRepository {
  static final DatabaseRepository instance = DatabaseRepository._init();

  static Database? _database;

  DatabaseRepository._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('kasa.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  FutureOr _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const notNullableTextType = 'TEXT NOT NULL';
    const nullableTextType = 'TEXT';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
    CREATE TABLE $tableAmount (
      ${AmountFields.id} $idType,
      ${AmountFields.category} $notNullableTextType,
      ${AmountFields.description} $nullableTextType,
      ${AmountFields.amount} $realType,
      ${AmountFields.isFixed} $boolType,
      ${AmountFields.dateTime} $notNullableTextType,
      ${AmountFields.period} $nullableTextType,
      ${AmountFields.isFirst} $boolType
    )
''');

    await db.execute('''
    CREATE TABLE $tableCategory (
      ${CategoryFields.id} $idType,
      ${CategoryFields.category} $notNullableTextType,
      ${CategoryFields.isIncome} $boolType
    )
''');

  //   await db.execute('''
  //   CREATE TABLE $tablePeriod (
  //     ${PeriodFields.id} $idType,
  //     ${PeriodFields.amountId} $integerType,
  //     ${PeriodFields.duration} $notNullableTextType,
  //     FOREIGN KEY (${PeriodFields.amountId}) REFERENCES $tableAmount (${AmountFields.id}) ON DELETE CASCADE
  //   )
  // ''');

    await db.insert(tableCategory,
        Category(id: 1, category: 'AİDAT', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 2, category: 'BAĞIŞ', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 3, category: 'ÇOCUK', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 4, category: 'EĞİTİM/KİTAP', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 5, category: 'EĞLENCE', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 6, category: 'EV & TADİLAT', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 7, category: 'FATURA', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 8, category: 'GİYİM', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 9, category: 'KİRA', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 10, category: 'KİŞİSEL BAKIM', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 11, category: 'KREDİ KARTI', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 12, category: 'SAĞLIK/SİGORTA', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 13, category: 'SEYEHAT', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 14, category: 'ULAŞIM / ARABA', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 15, category: 'YEMEK / MARKET', isIncome: false).toJson());
    await db.insert(tableCategory,
        Category(id: 16, category: 'MAAŞ', isIncome: true).toJson());
    await db.insert(tableCategory,
        Category(id: 17, category: 'SATIŞ', isIncome: true).toJson());
  }
}
