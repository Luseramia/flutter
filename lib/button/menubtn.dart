import 'package:rive/rive.dart';
import 'package:flutter/material.dart';

class Menubtn extends StatelessWidget {
  const Menubtn({
    Key? key,
    required this.press,
    required this.riveOnInit,
  }) : super(key: key);
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 8,
                ),
              ]),
          child: RiveAnimation.asset(
            "assets/RiveAssets/4880-9861-menu-button.riv",
            onInit: riveOnInit,
          ),
        ),
      ),
    );
  }
}
