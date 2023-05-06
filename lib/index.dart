import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'button/button.dart';
import 'button/glowing_button.dart';

class IndexApp extends StatefulWidget {
  const IndexApp({Key? key}) : super(key: key);

  @override
  State<IndexApp> createState() => _IndexAppState();
}

class _IndexAppState extends State<IndexApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/back.jpg"), fit: BoxFit.cover)),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/img/logo.jpg',
                width: MediaQuery.of(context).size.width * 0.9,
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 20,
              ),
              GlowingButton(
                color1: Colors.white70,
                color2: Colors.white70,
              ),
            ]),
          )),
    );
    ;
  }
}
