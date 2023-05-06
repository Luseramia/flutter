import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter_login/home.dart';
import 'package:flutter_login/index.dart';
import 'package:flutter_login/login.dart';
import 'package:flutter_login/rive_assets.dart';
import 'package:flutter_login/rive_util.dart';
import 'package:flutter_login/sildmenutile.dart';
import 'package:flutter_login/slidemenu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'homepage1.dart';
import 'infocard.dart';
import 'user.dart';
import 'button/glowing_button.dart';
import 'bottombar.dart';
import 'button/menubtn.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late SMIBool isMenuOpen;
  bool isSideMenuClosed = true;
  RiveAsset selectedMenu = sideMenues.first;
  int currentIndex = 0;
  late PageController _pageController;
  @override
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;

  @override
  void initState() {
    get_email();
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
    _pageController = PageController();
  }

  late var _email = " ";
  @override
  Future get_email() async {
    String? email = await user.getEmail();
    return _email = email.toString();
  }

  Future logout() async {
    await user.setsingin(false);
    await user.clearEmail();
    Navigator.pushNamed(context, 'login');
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Future all_image() async {
    var url = "http://192.168.139.160/flutter_login/image.php";
    final respones = await http.post(Uri.parse(url));
    return json.decode(respones.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Color.fromARGB(255, 29, 59, 170),
      body: Stack(children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          left: isSideMenuClosed ? -288 : 0,
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height,
          child: Scaffold(
            body: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: double.infinity,
                color: const Color(0xFF17203A),
                child: SafeArea(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Infocard(
                          name: _email,
                          profession: "ABC",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 32, bottom: 16),
                          child: Text(
                            "BROWSE",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white70),
                          ),
                        ),
                        ...sideMenues.map((menu) => Sidemenutile(
                              route: menu.route,
                              menu: menu,
                              riveonInit: (artboard) {
                                StateMachineController controller =
                                    RiveUtil.getRiveController(artboard,
                                        stateMachineName:
                                            menu.stateMachineName);
                                menu.input =
                                    controller.findSMI("active") as SMIBool;
                              },
                              press: () {
                                menu.input!.change(true);
                                Future.delayed(Duration(seconds: 1), () {
                                  menu.input!.change(false);
                                });
                                setState(() {
                                  selectedMenu = menu;
                                });
                                _pageController
                                    .jumpToPage(sideMenues.indexOf(menu));
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) => menu.route));
                              },
                              isActive: selectedMenu == menu,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 32, bottom: 16),
                          child: Text(
                            "HISTORY",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white70),
                          ),
                        ),
                        ...sideMenues2.map((menu) => Sidemenutile(
                              route: menu.route,
                              menu: menu,
                              riveonInit: (artboard) {
                                StateMachineController controller =
                                    RiveUtil.getRiveController(artboard,
                                        stateMachineName:
                                            menu.stateMachineName);
                                menu.input =
                                    controller.findSMI("active") as SMIBool;
                              },
                              press: () {
                                menu.input!.change(true);
                                Future.delayed(const Duration(seconds: 1), () {
                                  menu.input!.change(false);
                                });
                                setState(() {
                                  selectedMenu = menu;
                                });
                              },
                              isActive: selectedMenu == menu,
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: TextButton(
                              onPressed: () {
                                logout();
                              },
                              child: Text("logout"),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.black),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
        Transform(
          //มุมเอียง
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value - 30 * animation.value * pi / 180),
          child: Transform.translate(
            offset: Offset(animation.value * 245, 0), //first
            child: Transform.scale(
              scale: scalAnimation.value,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  children: [Page1(), login(), IndexApp()],
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
