import 'package:flutter/material.dart';
import 'package:flutter_login/test/test2.dart';

class Test1 extends StatefulWidget {
  const Test1({Key? key}) : super(key: key);

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  ;
                  parauser param1 = new parauser("tarchunk", "tar");
                  print("${param1.id}");
                },
                child: Icon(Icons.plus_one))
          ],
        ),
      )),
    );
  }
}
