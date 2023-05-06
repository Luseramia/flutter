import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/home.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'homepage.dart';
import 'user.dart';
import 'button/btnlogin.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var glowing = false;
  var scale = 1.0;
  bool loginfalse = false;
  @override
  final fromKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  Future signin() async {
    String url = "http://192.168.139.160/flutter_login/login.php";
    final respone = await http.post(Uri.parse(url), body: {
      'password': password.text,
      'email': email.text,
    });
    var data = json.decode(respone.body);
    if (data == "Error") {
      Navigator.pushNamed(context, 'login');
    } else {
      await user.setsingin(true);
      await user.setEmail(email.text);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Homepage();
      }));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: Form(
          key: fromKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.height * 0.5,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Image.asset('assets/img/logo.jpg')),
                  SizedBox(
                    child: Text(
                      "รหัสนักศึกษาหรือรหัสผ่านผิดพลาดกรุณากรอกใหม่อีกครั้ง",
                      style: TextStyle(
                          fontSize: loginfalse
                              ? MediaQuery.of(context).size.width * 0.03
                              : MediaQuery.of(context).size.width * 0,
                          color: Colors.redAccent),
                    ),
                    height: 50,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(30)),
                          errorBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(30)),
                          enabledBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(30)),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide:
                                BorderSide(color: Colors.yellow.shade200),
                          ),
                          labelText: 'รหัสนักศึกษา',
                          labelStyle: TextStyle(color: Colors.black45)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "โปรดใส่รหัสนักศึกษา";
                        } else {
                          return null;
                        }
                      },
                      controller: email,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(30)),
                        errorBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.yellow.shade200),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black45),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'โปรดใส่รหัสผ่าน';
                        } else {
                          return null;
                        }
                      },
                      controller: password,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTapUp: (val) {
                      bool pass = fromKey.currentState!.validate();
                      if (pass) {
                        signin();
                      }
                      setState(() {
                        glowing = false;
                        scale = 1.0;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        glowing = false;
                        scale = 1.0;
                      });
                    },
                    onTapDown: (val) {
                      setState(() {
                        glowing = true;
                        scale = 1.1;
                      });
                    },
                    child: AnimatedContainer(
                      transform: Matrix4.identity()..scale(scale),
                      duration: Duration(milliseconds: 100),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(9),
                          gradient: LinearGradient(
                            colors: [Colors.yellowAccent, Colors.yellowAccent],
                          ),
                          boxShadow: glowing
                              ? [
                                  BoxShadow(
                                    color: Colors.yellowAccent.withOpacity(0.6),
                                    spreadRadius: 1,
                                    blurRadius: 16,
                                    offset: (Offset(-8, 0)),
                                  ),
                                  BoxShadow(
                                    color: Colors.yellowAccent.withOpacity(0.6),
                                    spreadRadius: 1,
                                    blurRadius: 16,
                                    offset: (Offset(8, 0)),
                                  ),
                                  BoxShadow(
                                    color: Colors.yellowAccent.withOpacity(0.2),
                                    spreadRadius: 16,
                                    blurRadius: 32,
                                    offset: (Offset(-8, 0)),
                                  ),
                                  BoxShadow(
                                    color: Colors.yellowAccent.withOpacity(0.2),
                                    spreadRadius: 16,
                                    blurRadius: 32,
                                    offset: (Offset(8, 0)),
                                  )
                                ]
                              : []),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "เข้าสู่ระบบ",
                            style: TextStyle(color: Colors.black, fontSize: 19),
                          ),
                          Icon(
                            Icons.login,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 350,
                  //   height: 60,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         primary: const Color(0xFF3F60A0),
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(15))),
                  //     onPressed: () {
                  //       bool pass = fromKey.currentState!.validate();
                  //       if (pass) {
                  //         signin();
                  //       }
                  //     },
                  //     child: const Text(
                  //       'Sign in',
                  //       style: TextStyle(
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
