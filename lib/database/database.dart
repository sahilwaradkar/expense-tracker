import 'package:assignment/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider extends ChangeNotifier{

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  String reportType = "Income";

  void changeReportType(String type){
    reportType = type;
    notifyListeners();
  }

  double income = 0;
  double expense = 0;
  double balance = 0;
  Database? _database;

  Future<Database?> get database async{
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'expense_tracker.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> closeDatabase() async {
    if (_database != null) await _database!.close();
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL,
        category TEXT,
        desc TEXT,
        date TEXT,
        type TEXT
      )
    ''');
    // Create other tables if needed
  }

  Future<void> insertTransaction(TransactionModel transaction) async {
    final Database? db = await database;
    await db!.insert('transactions', transaction.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await getTransactions();
    await updateBalance();
    notifyListeners();
  }

  Future<List<TransactionModel>> getTransactions() async {
    debugPrint("Print");
    final Database? db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('transactions');
    _transactions =  List.generate(maps.length, (i) {
      debugPrint("maps -->> ${maps}");
      return TransactionModel.fromMap(maps[i]);
    });
    return _transactions;
  }

  Future<void> updateBalance ()async{
    income = 0;
    expense = 0;
    balance = 0;
    for (var transaction in transactions) {
      if (transaction.type.toLowerCase() == 'income') {
        income += transaction.amount;
      } else if (transaction.type.toLowerCase() == 'expense') {
        expense += transaction.amount;
      }
    }
    balance = income - expense;
    notifyListeners();
  }

}