import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_mangment_flutter/models/transation/transation_model.dart';

const TRANSACTION_DB_NAME = 'trasaction-db';

abstract class TransactionDbFuntion {
  Future<void> addTransaction(TransationModel obj);
  Future<List<TransationModel>> getALLTransactions();
  Future<void> deleteTransation(String id);
}

class TransationDB implements TransactionDbFuntion {
  TransationDB._internal();
  static TransationDB instance = TransationDB._internal();
  factory TransationDB() {
    return instance;
  }

  ValueNotifier<List<TransationModel>> transationListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransationModel obj) async {
    final _db = await Hive.openBox<TransationModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getALLTransactions();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transationListNotifier.value.clear();
    transationListNotifier.value.addAll(_list);

    transationListNotifier.notifyListeners();
  }

  @override
  Future<List<TransationModel>> getALLTransactions() async {
    final _db = await Hive.openBox<TransationModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deleteTransation(String id) async {
    final _db = await Hive.openBox<TransationModel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
  }
}
