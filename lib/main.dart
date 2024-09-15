import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_db/bloc/todo_bloc.dart';
import 'package:todo_bloc_db/database/local/db_helper.dart';
import 'package:todo_bloc_db/provider/theme_provider.dart';
import 'package:todo_bloc_db/screens/home_screen.dart';
import 'package:todo_bloc_db/splash/login_page.dart';
import 'package:todo_bloc_db/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MultiBlocListener(listeners: [
    BlocProvider(create: (context){
      return TodoBloc(mainDb: DbHelper.getInstances);
    }),
    ChangeNotifierProvider(create: (context){
      return ThemeProvider();
    })
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      themeMode: context.watch<ThemeProvider>().getTheme() ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(),
    );
  }
}

