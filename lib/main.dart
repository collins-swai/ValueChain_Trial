import 'dart:io';
import 'package:activity/activity.dart';
import 'package:flutter/material.dart';
import 'package:todo_valuechain/controller/main_controller.dart';
import 'package:todo_valuechain/presentation/splash_screen.dart';
import 'package:quickeydb/quickeydb.dart';

import 'database/TaskSchema.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await QuickeyDB.initialize(
    dbName: "QuickeyDB.db",
    persist: true,
    dbVersion: 4,
    dbPath: Directory.current.path,
    dataAccessObjects: [
      TaskSchema(),
    ],
  );


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(),
      home: Activity(
        MainController(),
        onActivityStateChanged: () =>
            DateTime.now().microsecondsSinceEpoch.toString(),
        child: SplashScreen(),
      ),
      // home: SplashScreen(),
    );
  }
}
