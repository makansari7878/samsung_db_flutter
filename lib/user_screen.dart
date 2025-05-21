import 'package:flutter/material.dart';


import 'User.dart';
import 'UserDao.dart';

class UserScreen extends StatefulWidget {
  final UserDao userDao; // Receive UserDao via constructor

  const UserScreen({Key? key, required this.userDao}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  List<User> _users = [];

  Future<void> _addUser() async {
    final email = _emailController.text;
    final phone = _phoneController.text;
    if (email.isNotEmpty && phone.isNotEmpty) {
      await widget.userDao.insertUser(
        User(email: email, phone: phone),
      );
      _emailController.clear();
      _phoneController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User added!')),
      );
    }
  }

  Future<void> _showUsers() async {
    final users = await widget.userDao.getAllUsers();
    setState(() {
      _users = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Database App')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addUser,
                  child: const Text('Add User'),
                ),
                ElevatedButton(
                  onPressed: _showUsers,
                  child: const Text('Show Users'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_users[index].email, style: TextStyle(fontSize: 20),),
                    subtitle: Text(_users[index].phone,style: TextStyle(fontSize: 20), ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }



  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}