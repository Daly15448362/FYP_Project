import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fyp_project/monetary//currency.dart';
import 'package:fyp_project/monetary/transaction.dart';
import 'package:fyp_project/database/database.dart';

class DatabaseService {
  static const String _databaseName = "DalyBudget.db";
  static const String _keyCurrency = "currency";
  static const String _keyBudget = "budget";
  Database dbHelp = new Database();
  SharedPreferences sharedPrefs;

  Future open() async {
    sharedPrefs = await SharedPreferences.getInstance();
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return dbHelp.open(path);
  }

  Future<List<Transaction>> getCurrentTransactions() async {
    return dbHelp.getAllTransactions();
  }

  Future<Transaction> addTransaction(Transaction transaction) {
    return dbHelp.insertTransaction(transaction);
  }

  Future close() async {
    return dbHelp.close();
  }

  Currency getCurrency() {
    return Currency.fromString(sharedPrefs.getString(_keyCurrency));
  }

  void saveCurrency(Currency currency) {
    sharedPrefs.setString(_keyCurrency, currency.toString());
  }

  double getStartingBudget() {
    return sharedPrefs.getDouble(_keyBudget);
  }

  Future saveStartingBudget(double budget, {bool reset = false}) async {
    sharedPrefs.setDouble(_keyBudget, budget);
    if (reset) {
      await dbHelp.deleteAllTransaction();
    }
  }
}
