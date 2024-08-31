
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_bloc_db/database/local/db_helper.dart';
import 'package:todo_bloc_db/splash/sign_up_page.dart';

import '../screens/home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  SharedPreferences? prefs;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Login")),
      ),
      body: Padding(
        padding:  EdgeInsets.all(8.0),
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
            InkWell(
              onTap: () async {
                var db = DbHelper.getInstances;
                bool check =await db.checkAuthenticate(emailController.text.toString(), passwordController.text.toString());
                !check
                    ? ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Invalid credentials"),))
                    : Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return HomeScreenDb();
                    }));
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
                      "Login",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return SignUpPage();
                  }));
                },
                child: Text("you don't have an account? create",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}
