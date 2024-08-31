import 'package:todo_bloc_db/database/local/db_helper.dart';
import 'package:todo_bloc_db/models/user_model.dart';

import 'login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;
  SharedPreferences? prefs;
  DbHelper? mainDb;
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sign Up",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                /*------------First Name TextField---------*/
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: fNameController,
                    decoration: InputDecoration(
                        hintText: "First Name",
                        labelText: "First Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                /*------------Last Name TextField---------*/
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: lNameController,
                    decoration: InputDecoration(
                        hintText: "Last name",
                        labelText: "Last Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            /*------------Email TextField---------*/
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "abc@gmail.com",
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            /*------------Phone TextField---------*/
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                  hintText: "10 digit number",
                  labelText: "Phone no",
                  prefixIcon: Icon(Icons.phone_android_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            /*------------Password TextField---------*/
            TextField(
              obscureText: true,
              obscuringCharacter: "*",
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                  prefixIcon: _obscureText == true
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onTap: () {
                _obscureText = false;
                setState(() {});
              },
            ),
            SizedBox(
              height: 10,
            ),
            /*------------Navigate to Login---------*/
            InkWell(
              onTap: () async{
                var db = DbHelper.getInstances;
                bool check = await db.signUp(UserModel(

                    fname: fNameController.text.toString(),
                    lname: lNameController.text.toString(),
                    email: emailController.text.toString(),
                    phone: phoneController.text.toString(),
                    pass: passwordController.text.toString()));
                if (!check) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("User Alread Exist"),
                        action: SnackBarAction(
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return LoginPage();
                            }));
                          },
                          label: "login",
                        ),));
                }
                else{
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                }
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            /*------------If Already have account navigate to login---------*/
            InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                },
                child: Text(
                  "Already have an account?",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

}