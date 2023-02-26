import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart'; 

void main() async{
 await Hive.initFlutter(); 
 await Hive.openBox("Habit_Database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Home(),
    );
  }
}
