import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileStorage extends StatefulWidget {
  const FileStorage({super.key});

  @override
  State<FileStorage> createState() => _FileStorageState();
}

class _FileStorageState extends State<FileStorage> {
  final TextEditingController textController = TextEditingController();
  String textFromFile = '';


  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/data.txt');
  }

  Future<File> writeToFile(String text) async {
    final file = await localFile;
    return file.writeAsString(text);
  }

  Future<String> readFromFile() async {
    try {
      final file = await localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return  'NO CONTENT' + 'Error:  $e';
    }
  }


  Future<File> appendToFile(String newText) async {
    final file = await localFile;
    String currentContent = '';
    try {
      currentContent = await file.readAsString();
    } catch (e) {
      // If file doesn't exist or error, treat as empty
      currentContent = '';
    }
    final newContent = currentContent + (currentContent.isEmpty ? '' : '\n') + newText;
    return file.writeAsString(newContent);
  }


  @override
  void initState() {
    // TODO: implement initState
    stateOfFile();
  }

  void stateOfFile() async {
    final text = await readFromFile();
    setState(() {
      textFromFile = text;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Storage Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: textController,
              decoration: InputDecoration(labelText: 'Enter text'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                writeToFile(textController.text);
                stateOfFile();
                textController.clear();
              },
              child: Text('Save to File'),
            ),
            SizedBox(height: 20),
            Text('Text from file:'),
            Text(textFromFile),

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                appendToFile(textController.text);
                stateOfFile();
                textController.clear();
              },
              child: Text('Append to File'),

            ),

          ],
        ),
      ),
    );
  }
}

