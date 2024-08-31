import 'package:todo_bloc_db/database/local/db_helper.dart';

class UserModel {
  int? uid;
  String fname;
  String lname;
  String email;
  String pass;
  String phone;

  UserModel({
    this.uid,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.pass
  });

  factory UserModel.fromMap(Map<String, dynamic>map){
    return UserModel(
        uid: map[DbHelper.User_Id],
        phone: map[DbHelper.User_phone],
        fname: map[DbHelper.User_fName],
        lname: map[DbHelper.User_lName],
        email: map[DbHelper.User_Email],
        pass: map[DbHelper.User_Pass]);
  }

  Map<String,dynamic> toMap(){
    return {
      DbHelper.User_Id : uid,
      DbHelper.User_fName: fname,
      DbHelper.User_lName: lname,
      DbHelper.User_phone : phone,
      DbHelper.User_Email : email,
      DbHelper.User_Pass : pass
    };
  }
}