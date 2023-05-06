import 'package:flutter/material.dart';

class Button1 extends StatefulWidget {
  const Button1({Key? key}) : super(key: key);

  @override
  State<Button1> createState() => _Button1State();
}

class _Button1State extends State<Button1> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'login');
        },
        child: Text("Login"),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20),
            fixedSize: Size(300, 80),
            textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            primary: Colors.yellow,
            onPrimary: Colors.black87,
            elevation: 15,
            shadowColor: Colors.yellow,
            side: BorderSide(color: Colors.black87, width: 2),
            shape: StadiumBorder()));
    ;
  }
}
