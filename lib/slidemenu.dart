import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_login/homepage.dart';
import 'package:flutter_login/rive_assets.dart';
import 'package:http/http.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'infocard.dart';
import 'sildmenutile.dart';
import 'rive_util.dart';
import 'user.dart';
import 'homepage.dart';

class Slide_menu extends StatefulWidget {
  const Slide_menu({Key? key}) : super(key: key);

  State<Slide_menu> createState() => _Slide_menuState();
}

class _Slide_menuState extends State<Slide_menu> {
  RiveAsset selectedMenu = sideMenues.first;
  int index = 0;
  Homepage home = Homepage();

  @override
  void initState() {
    get_email();
    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: double.infinity,
          color: const Color(0xFF17203A),
          child: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Infocard(
                name: _email,
                profession: "ABC",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
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
                              stateMachineName: menu.stateMachineName);
                      menu.input = controller.findSMI("active") as SMIBool;
                    },
                    press: () {
                      menu.input!.change(true);
                      Future.delayed(Duration(seconds: 1), () {
                        menu.input!.change(false);
                      });
                      setState(() {
                        selectedMenu = menu;
                      });
                      index = sideMenues.indexOf(menu);

                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => menu.route));
                    },
                    isActive: selectedMenu == menu,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
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
                              stateMachineName: menu.stateMachineName);
                      menu.input = controller.findSMI("active") as SMIBool;
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
                    style: TextButton.styleFrom(backgroundColor: Colors.black),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
