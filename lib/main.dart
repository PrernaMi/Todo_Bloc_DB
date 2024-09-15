import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:todo_bloc_db/bloc/todo_bloc.dart';
import 'package:todo_bloc_db/database/local/db_helper.dart';
import 'package:todo_bloc_db/screens/home_screen.dart';
import 'package:todo_bloc_db/splash/login_page.dart';
import 'package:todo_bloc_db/splash/splash_screen.dart';

void main() {
  runApp( BlocProvider(create: (context){
    return TodoBloc(mainDb: DbHelper.getInstances);
  },child: MyApp(),));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          canvasColor: Colors.white,
          useMaterial3: true,
          colorScheme: ColorScheme.light(
            background: Colors.white,
          )
      ),
      darkTheme: ThemeData(
          canvasColor: Colors.black,
          colorScheme: ColorScheme.dark(
              background: Colors.black
          )
      ),
      themeMode: ThemeMode.dark,
      home: SplashScreen(),
    );
  }
}

