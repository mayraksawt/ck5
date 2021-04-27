import 'dart:io';

import 'package:ck5/models/Transactions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  //บริการเกี่ยวกับฐานข้อมูล
  String dbName;
  //ถ้าไม่มีให้สร้าง
  //ถ้าสร้างแล้วให้เปิด
  TransactionDB({this.dbName});

  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    //สร้าง database
    // ignore: await_only_futures
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล
  // ignore: non_constant_identifier_names
  Future<int> InsertData(Transactions statement) async {
    //ฐานข้อมูล => Store
    // transaction.db => expense
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    // json
    var keyID = store.add(db, {
      "name": statement.name,
      "lastname": statement.lastname,
      "Address": statement.address,
      "phone": statement.phone,
      "email": statement.email,
      "password": statement.password,
      "date": statement.date.toIso8601String()
    });
    db.close();
    return keyID;
  }

  // ใหม่ => เก่า false มาก => น้อย
  // เก่า => ใหม่ true น้อย => มาก
  Future<List<Transactions>> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db,
        finder: Finder(
            sortOrders: [SortOrder(Field.key, false)])); //เรียงจากใหม่ไปเก่า
    // ignore: deprecated_member_use
    List transactionList = List<Transactions>();
    //ดึงมาทีละแถว
    for (var record in snapshot) {
      transactionList.add(Transactions(
          name: record["name"],
          lastname: record["lastname"],
          address: record["address"],
          phone: record["phone"],
          email: record["email"],
          password: record["password"],
          date: DateTime.parse(record["date"])));
    }
    return transactionList;
  }
}
