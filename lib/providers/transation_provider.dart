import 'package:flutter/foundation.dart';
import 'package:ck5/models/Transactions.dart';
import 'package:ck5/database/transaction_db.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];
  List<Transactions> getTransctions() {
    return transactions;
  }

  void initData() async {
    var db = TransactionDB(dbName: "transactions.db");
    //ดึงข้อมูลมาแสดงผล
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void addTransaction(Transactions statement) async {
    var db = TransactionDB(dbName: "transactions.db");
    //บันทึกข้อมูล
    await db.InsertData(statement);
    //ดึงข้อมูลมาแสดงผล
    transactions = await db.loadAllData();
    //แจ้งเตือน Consumer
    notifyListeners();
  }
}
