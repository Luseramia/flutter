import 'package:flutter/material.dart';

class GlowingButton extends StatefulWidget {
  const GlowingButton(
      {Key? key, this.color1 = Colors.cyan, this.color2 = Colors.greenAccent})
      : super(key: key);
  final Color color1;
  final Color color2;
  @override
  State<GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton> {
  var glowing = false;
  var scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (val) {
        setState(() {
          glowing = false;
          scale = 1.0;
        });
        Navigator.pushNamed(context, "login");
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
              colors: [widget.color1, widget.color2],
            ),
            boxShadow: glowing
                ? [
                    BoxShadow(
                      color: widget.color1.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 16,
                      offset: (Offset(-8, 0)),
                    ),
                    BoxShadow(
                      color: widget.color1.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 16,
                      offset: (Offset(8, 0)),
                    ),
                    BoxShadow(
                      color: widget.color1.withOpacity(0.2),
                      spreadRadius: 16,
                      blurRadius: 32,
                      offset: (Offset(-8, 0)),
                    ),
                    BoxShadow(
                      color: widget.color1.withOpacity(0.2),
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
    );
  }
}
