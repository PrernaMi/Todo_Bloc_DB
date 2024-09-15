import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_db/bloc/todo_bloc.dart';
import 'package:todo_bloc_db/database/local/db_helper.dart';
import 'package:todo_bloc_db/provider/theme_provider.dart';
import 'package:todo_bloc_db/splash/splash_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiBlocListener(listeners: [
    BlocProvider(
        create: (context) => TodoBloc(mainDb: DbHelper.getInstances)),
    ChangeNotifierProvider(create: (context) => ThemeProvider())
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    context.read<ThemeProvider>().getDefaultTheme();
    super.initState();
  }
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
      themeMode: context.watch<ThemeProvider>().getTheme() ? ThemeMode.dark : ThemeMode.light ,
      home: SplashScreen(),
    );
  }
}

