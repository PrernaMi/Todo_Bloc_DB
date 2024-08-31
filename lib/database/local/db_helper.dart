import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_bloc_db/models/user_model.dart';
import '../../models/todo_model.dart';

class DbHelper {
  DbHelper._();

  static final getInstances = DbHelper._();

  SharedPreferences? prefs ;
  //tables
  static String table_Note = 'note';
  static String table_User = 'user';

  //Note Database table column
  //we have to add user id in this table
  static String table_Col_Title = 'title';
  static String table_Col_Desc = 'desc';
  static String table_Col_IsComp = 'is_comp';
  static String table_Col_S_no = 's_no';

  //user table column
  static String User_Id = 'uid';
  static String User_fName = 'fname';
  static String User_lName = 'lname';
  static String User_Email = 'email';
  static String User_phone = 'phone';
  static String User_Pass = 'pass';

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
          $User_Id integer,
          $table_Col_IsComp Integer)''');

      db.rawQuery('''create table $table_User ( 
          $User_Id Integer primary key autoincrement , 
          $User_fName text , 
          $User_lName text ,
          $User_Email text unique,
          $User_phone text,
          $User_Pass text
          )''');
    });
  }

  Future<bool> addInDb({required ListModel newModel}) async {
    var db = await getDb();
    int uid = await getUID();
    newModel.uid = uid;
    int count = await db.insert(
        table_Note,
        newModel.toMap());
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
    int uid = await getUID();
    var data = await db.query(table_Note,where: '$User_Id = ?',whereArgs: ['$uid']);
    List<ListModel> list = [];
    for (Map<String, dynamic> eachMap in data) {
      list.add(ListModel.fromMap(map: eachMap));
    }
    return list;
  }

  Future<bool> updateIsComInDb({required int isComp, required int s_no}) async {
    var db = await getDb();
    int uid = await getUID();
    int count = await db.update(
        table_Note,
        {
          table_Col_IsComp: isComp,
        },
        where: '$table_Col_S_no = ? and $User_Id = ?',
        whereArgs: [s_no,uid]);
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

  //signUp to new User but first we will check if is not already registered

  Future<bool> signUp(UserModel newUser) async {
    var db = await getDb();
    bool check = await checkIfUserExist(newUser.email);
    bool rowsEffected = false;
    if(!check){
      int count = await db.insert(table_User, newUser.toMap());
      rowsEffected = count>0;
    }
    return rowsEffected;
  }

  //check is user exist if yes return true else return false
  Future<bool> checkIfUserExist(String email) async {
    var db = await getDb();
    var data = await db.query(table_User,
        where: '$User_Email = ?', whereArgs: [email]);
    return data.isNotEmpty;
  }

  //login--> check authenticate user
   Future<bool> checkAuthenticate(String email,String pass)async{
    var db = await getDb();
    var data = await db.query(table_User,
        where: '$User_Email = ? and $User_Pass = ?', whereArgs: [email,pass]);
    if(data.isNotEmpty){
      setUId(data);
    }
    return data.isNotEmpty;
   }

   void setUId(var data)async{
     prefs =await SharedPreferences.getInstance();
     prefs!.setInt("uid", UserModel.fromMap(data[0]).uid!);
   }

   Future<int> getUID()async{
     prefs =await SharedPreferences.getInstance();
     int id =  prefs!.getInt('uid')!;
     return id;
   }
}
