import 'package:flutter/material.dart';
import 'package:samsum_db_proj/user_screen.dart';
import 'UserDao.dart';
import 'app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the database
  final database = await $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .build();
  final userDao = database.userDao;

  runApp(MyApp(userDao: userDao));
}

class MyApp extends StatelessWidget {
  final UserDao userDao;

  const MyApp({super.key, required this.userDao});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserScreen(userDao: userDao),
    );
  }
}