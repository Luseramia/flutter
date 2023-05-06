import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_login/rive_util.dart';
import 'package:flutter_login/slidemenu.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rive/rive.dart';
import 'button/menubtn.dart';
import 'user.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  late SMIBool isMenuOpen;
  bool isSideMenuClosed = true;

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;

  late var _email = " ";
  @override
  Future get_email() async {
    String? email = await user.getEmail();
    return _email = email.toString();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Colors.white,
      body: Stack(children: [
        AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideMenuClosed ? -288 : 0,
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height,
            child: Slide_menu()),
        Transform(
          //มุมเอียง
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value - 30 * animation.value * pi / 180),
          child: Transform.translate(
            offset: Offset(animation.value * 235, 0), //first
            child: Transform.scale(
              scale: scalAnimation.value,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Expanded(
                  child: FutureBuilder(
                    future: get_email(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? Container(
                              decoration: BoxDecoration(),
                              child: Center(
                                child: Container(
                                  child: QrImage(
                                    data: _email,
                                    size: 200,
                                    backgroundColor: Colors.white12,
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
              ),
            ),
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
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          left: isSideMenuClosed ? 0 : 220,
          top: 16,
          child: Menubtn(
            riveOnInit: (artboard) {
              StateMachineController controller = RiveUtil.getRiveController(
                  artboard,
                  stateMachineName: "switch");
              isMenuOpen = controller.findSMI("toggleX") as SMIBool;
              isMenuOpen.value = true;
            },
            press: () {
              isMenuOpen.value = !isMenuOpen.value;
              if (isSideMenuClosed) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
              setState(() {
                isSideMenuClosed = isMenuOpen.value;
              });
            },
          ),
        ),
      ]),
    );
  }
}
