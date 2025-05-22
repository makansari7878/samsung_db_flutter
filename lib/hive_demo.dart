import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveDemo extends StatefulWidget {
  const HiveDemo({super.key});

  @override
  State<HiveDemo> createState() => _HiveDemoState();
}

class _HiveDemoState extends State<HiveDemo> {

  bool _showData = false;
  storeData() async{
    var box = await Hive.openBox('hivefile');
    box.put('studentName', 'ANSARI');
    box.put('age', 22);
    box.put('details', {
      'email' : 'ansari@gmail.com',
      'phone' : 585858555
    });
  }

  Widget showData(){
    return FutureBuilder(
        future: Hive.openBox('hivefile'),
        builder: (context, snapshot){

          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }

          var box = snapshot.data!;
          var details = box.get('details', defaultValue: {}) as Map;

          return Column(
            children: [
              Text('Student Name : ${box.get('studentName', defaultValue: 'unknown')}',
                style: TextStyle(color: Colors.white, fontSize: 22),),
              Text('Student Age : ${box.get('age' , defaultValue: 'N/A')}'),
              Text('Student Email : ${details['email'] ?? "N/A"}' ),
              Text('Student Email : ${details['phone'] ?? "N/A"}' )
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(

        children: [
          SizedBox(height: 40,),
              Row(
                children: [
                  ElevatedButton(onPressed: storeData, child: Text('Add Data')),
                ],
              ),
          SizedBox(height: 40,),
          Row(
            children: [
              ElevatedButton(onPressed: (){
                setState(() {
                  _showData = true;  // Show the FutureBuilder widget
                });
              }, child: Text('show Data')),
            ],
          ),
          SizedBox(height: 40,),
          if (_showData) showData(),

        ],
    )
    );


  }
}
