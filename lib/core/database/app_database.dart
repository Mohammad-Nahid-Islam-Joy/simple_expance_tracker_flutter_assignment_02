import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:expance_tracker/models/transaction.dart';

part 'app_database.g.dart';

@DataClassName('TransactionEntry')
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get type => text()();
  RealColumn get amount => real()();
  DateTimeColumn get time => dateTime()();
}

@DriftDatabase(tables: [Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  static final AppDatabase instance = AppDatabase._internal();

  factory AppDatabase([QueryExecutor? executor]) {
    if (executor != null) {
      return AppDatabase._internal(executor);
    }
    return instance;
  }

  @override
  int get schemaVersion => 1;

  Stream<List<Transaction>> watchAllTransactions() {
    return select(transactions).watch().map((entries) {
      final result = entries.map((entry) {
        return Transaction(
          id: entry.id,
          name: entry.name,
          description: entry.description,
          type: entry.type,
          amount: entry.amount,
          time: entry.time,
        );
      }).toList();

      return result;
    });
  }

  Future<List<Transaction>> getAllTransaction() async {
    final entries = await select(transactions).get();

    return entries.map((entry) {
      return Transaction(
        id: entry.id,
        name: entry.name,
        description: entry.description,
        type: entry.type,
        amount: entry.amount,
        time: entry.time,
      );
    }).toList();
  }

  Future<int> insertTransaction(Transaction transaction) {
    return into(transactions).insert(
      TransactionsCompanion.insert(
        name: transaction.name,
        description: transaction.description,
        type: transaction.type,
        amount: transaction.amount,
        time: transaction.time,
      ),
    );
  }

  Future<bool> updateTransactions(Transaction transaction) {
    if (transaction.id == null) return Future.value(false);

    return update(transactions).replace(
      TransactionEntry(
        id: transaction.id!,
        name: transaction.name,
        description: transaction.description,
        type: transaction.type,
        amount: transaction.amount,
        time: transaction.time,
      ),
    );
  }

  Future<int> deleteTransaction(int id) {
    return (delete(
      transactions,
    )..where((transaction) => transaction.id.equals(id))).go();
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'expance_app_db');
  }
}
