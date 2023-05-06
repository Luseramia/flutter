import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

class parauser {
  late String name = " ";
  late String id = " ";
  parauser(String name, String id) {
    this.id = id;
    this.name = name;
  }

  static Future getid() async {
    return;
  }
}
