import 'package:floor/floor.dart';

@Entity(tableName: 'users')
class User {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String email;
  final String phone;

  User({this.id, required this.email, required this.phone});
}