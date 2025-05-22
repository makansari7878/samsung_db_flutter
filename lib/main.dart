import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samsum_db_proj/file_storage.dart';
import 'package:samsum_db_proj/hive_demo.dart';
import 'package:samsum_db_proj/user_screen.dart';
import 'UserDao.dart';
import 'app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var myDirectory = await getApplicationDocumentsDirectory();
  Hive.init(myDirectory.path); 


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
      //home: UserScreen(userDao: userDao),
      home: HiveDemo(),
    );
  }
}