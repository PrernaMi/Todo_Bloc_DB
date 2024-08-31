import 'dart:async';
import 'package:todo_bloc_db/database/local/db_helper.dart';

import '../screens/home_screen.dart';
import 'login_page.dart';
import 'sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? prefs;
  int? uid;

  @override
  void initState() {
    nextPage();
    super.initState();
  }

  Widget page = HomeScreenDb();

  DbHelper? mainDb = DbHelper.getInstances;
  void nextPage()async{
    uid =await mainDb!.getUID();
    if(uid == null || uid == 0){
      page = LoginPage();
    }

    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return page;
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.greenAccent.shade100,
        child: FlutterLogo(size: 30,),
      ),
    );
  }
}