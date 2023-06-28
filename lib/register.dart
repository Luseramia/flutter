// ignore_for_file: prefer_const_constructors
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/login.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'homepage.dart';
import 'user.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  @override
  final fromKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  Future signup() async {
    String url = "http://192.168.1.56/flutter_login/register.php";
    final respone = await http.post(Uri.parse(url), body: {
      'name': name.text,
      'password': password.text,
      'email': email.text
    });
    var data = json.decode(respone.body);
    if (data == "Error") {
      Navigator.pushNamed(context, 'register');
    } else {
      await user.setsingin(true);
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
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Please complete your',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Text(
                    'biodata correctly',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Your name',
                      ),
                      controller: name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Your E-Mail',
                      ),
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Create your Password',
                      ),
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Re-Type your Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Empty';
                        } else if (value != password.text) {
                          return "Password not match";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF3F60A0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                        bool pass = fromKey.currentState!.validate();
                        if (pass) {
                          signup();
                        }
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
