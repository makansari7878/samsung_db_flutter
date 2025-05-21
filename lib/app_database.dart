// app_database.dart
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'User.dart';
import 'UserDao.dart';

part 'app_database.g.dart'; // Generated file


@Database(version: 1, entities: [User])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
}