import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Buttombar extends StatefulWidget {
  const Buttombar({Key? key}) : super(key: key);

  @override
  State<Buttombar> createState() => _ButtombarState();
}

class _ButtombarState extends State<Buttombar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabActiveBorder: Border.all(
            color: Colors.white.withOpacity(0.7),
          ),
          padding: EdgeInsets.all(10),
          gap: 8,
          onTabChange: (index) {
            print(index);
          },
          tabs: [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.settings,
              text: "Setting",
            ),
            GButton(
              icon: Icons.favorite_border,
              text: "Fav",
            ),
          ],
        ),
      ),
    );
  }
}
