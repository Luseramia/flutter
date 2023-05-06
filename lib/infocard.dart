import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/src/widgets/framework.dart';

class Infocard extends StatelessWidget {
  const Infocard({
    Key? key,
    this.name,
    this.profession,
  }) : super(key: key);
  final profession;
  final name;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
        backgroundColor: Colors.white24,
      ),
      title: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        profession,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
