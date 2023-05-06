// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter_login/rive_assets.dart';
import 'package:flutter_login/rive_util.dart';
import 'package:flutter_login/slidemenu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'user.dart';
import 'button/glowing_button.dart';
import 'bottombar.dart';
import 'button/menubtn.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage>
    with SingleTickerProviderStateMixin {
  late SMIBool isMenuOpen;
  bool isSideMenuClosed = true;

  late AnimationController _animationController;
  late Animation<double> animation;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future logout() async {
    await user.setsingin(false);
    Navigator.pushNamed(context, 'login');
  }

  Future all_image() async {
    var url = "http://192.168.162.160/flutter_login/image.php";
    final respones = await http.post(Uri.parse(url));
    return json.decode(respones.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      // backgroundColor: Color(0xFFF5F5F5),
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   title: Text("Homepage Flutter Login-php"),
      // ),
      body: SafeArea(
          child: Column(
        children: [
          Positioned(
            //duration: Duration(milliseconds: 200),
            left: isSideMenuClosed ? -288 : 0,
            child: Slide_menu(),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height,
          ),
          Menubtn(
            riveOnInit: (artboard) {
              StateMachineController controller = RiveUtil.getRiveController(
                  artboard,
                  stateMachineName: "switch");
              isMenuOpen = controller.findSMI("toggleX") as SMIBool;
              isMenuOpen.value = true;
            },
            press: () {
              isMenuOpen.value = !isMenuOpen.value;
              // if (isSideMenuClosed) {
              //   _animationController.forward();
              // } else {
              //   _animationController.reverse();
              // }
              setState(() {
                isSideMenuClosed = isMenuOpen.value;
              });
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: all_image(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? Container(
                        child: Transform.scale(
                          scale: isSideMenuClosed ? 1 : 0.8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            child: Stack(
                              children: [
                                Container(
                                  child: ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        List list = snapshot.data;
                                        return Container(
                                          decoration: BoxDecoration(),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 40,
                                              ),
                                              Container(
                                                child: Image.network(
                                                  "http://192.168.56.1/flutter_login/uploads/${list[index]['image']}",
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white),
                                                child: Column(children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 1),
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          list[index]['name'],
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                  )
                                                ]),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Container(),
                      );
              },
            ),
          ),
          // Container(
          //   child: SizedBox(
          //     width: 350,
          //     height: 60,
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //           primary: const Color(0xFF3F60A0),
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(15))),
          //       onPressed: () {
          //         logout();
          //       },
          //       child: Text("Sign out"),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
        ],
      )),
    );

    // bottomNavigationBar: Buttombar(),
  }
}
