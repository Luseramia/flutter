import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'homepage.dart';
import 'user.dart';

class Checklogin extends StatefulWidget {
  const Checklogin({Key? key}) : super(key: key);

  @override
  State<Checklogin> createState() => _CheckloginState();
}

class _CheckloginState extends State<Checklogin> {
  Future checklogin() async {
    bool? signin = await user.getsignin();
    if (signin == false) {
      await user.clearEmail();
      Navigator.pushNamed(context, 'login');
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Homepage();
      }));
    }
  }

  void initState() {
    checklogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
