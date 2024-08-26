import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../models/todo_model.dart';

class DbHelper {
  DbHelper._();

  static final getInstances = DbHelper._();
  static String table_Note = 'note';
  static String table_Col_Title = 'title';
  static String table_Col_Desc = 'desc';
  static String table_Col_IsComp = 'is_comp';
  static String table_Col_S_no = 's_no';

  Database? myDb;

  Future<Database> getDb() async {
    myDb ??= await openDb();
    return myDb!;
  }

  Future<Database> openDb() async {
    Directory myDirectory = await getApplicationDocumentsDirectory();
    String rootPath = myDirectory.path;
    String dbPath = join(rootPath, "notes.db");

    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.rawQuery('''create table $table_Note ( 
          $table_Col_S_no Integer primary key autoincrement , 
          $table_Col_Title text , 
          $table_Col_Desc text ,
          $table_Col_IsComp Integer)''');
    });
  }

  Future<bool> addInDb({required ListModel newModel}) async {
    var db = await getDb();
    int count = await db.insert(
        table_Note,
        ListModel(
                title: newModel.title,
                desc: newModel.desc,
                isComp: newModel.isComp)
            .toMap());
    return count > 0;
  }

  Future<bool> updateInDb(
      {required ListModel newModel, required int s_no}) async {
    var db = await getDb();
    int count = await db.update(
        table_Note,
        {
          DbHelper.table_Col_Title: newModel.title,
          DbHelper.table_Col_Desc: newModel.desc
        },
        where: '$table_Col_S_no = ?',
        whereArgs: [s_no]);
    return count > 0;
  }

  Future<bool> deleteInDb({required int s_no}) async {
    var db = await getDb();
    int count = await db
        .delete(table_Note, where: '$table_Col_S_no = ?', whereArgs: [s_no]);
    return count > 0;
  }

  Future<List<ListModel>> getFromDb() async {
    var db = await getDb();
    var data = await db.query(table_Note);
    List<ListModel> list = [];
    for (Map<String, dynamic> eachMap in data) {
      list.add(ListModel.fromMap(map: eachMap));
    }
    return list;
  }

  Future<bool> updateIsComInDb({required int isComp, required int s_no}) async {
    var db = await getDb();
    int count = await db.update(
        table_Note,
        {
          table_Col_IsComp: isComp,
        },
        where: '$table_Col_S_no = ?',
        whereArgs: [s_no]);
    return count > 0;
  }

  Future<double> getIsCompDb() async {
    var db = await getDb();
    var c = await db.rawQuery(
        'select count($table_Col_IsComp) as count from $table_Note where $table_Col_IsComp = ?',
        [1]);
    int count = Sqflite.firstIntValue(c) ?? 0;
    return count.toDouble();
  }
}
