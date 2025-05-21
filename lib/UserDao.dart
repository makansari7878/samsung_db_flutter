// lib/data/user_dao.dart
import 'package:floor/floor.dart';

import 'User.dart';

@dao
abstract class UserDao {
  @Insert()
  Future<void> insertUser(User user);

  @Query('SELECT * FROM users')
  Future<List<User>> getAllUsers();
}