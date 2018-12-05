import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:fyp_project/monetary/transaction.dart';

const String tableTransactions = "_transactions";

class Database {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableTransactions ( 
  $columnId integer primary key autoincrement, 
  $columnValue real not null,
  $columnDate integer not null)
''');
    });
  }

  Future<Transaction> insertTransaction(Transaction transaction) async {
    transaction.id = await db.insert(tableTransactions, transaction.toMap());
    return transaction;
  }

  Future<List<Transaction>> getAllTransactions() async {
    return (await db.query(
      tableTransactions,
      columns: [columnId, columnValue, columnDate],
    ))
        .map((map) => new Transaction.fromMap(map))
        .toList();
  }

  Future<int> deleteAllTransaction() async {
    return await db.delete(tableTransactions);
  }

  Future close() async => db.close();
}
