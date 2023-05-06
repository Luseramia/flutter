import 'package:flutter_login/QrCode.dart';
import 'package:flutter_login/homepage.dart';
import 'package:flutter_login/index.dart';
import 'package:flutter_login/login.dart';
import 'package:rive/rive.dart';

import 'QR.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  final route;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.route,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> sideMenues = [
  RiveAsset("assets/RiveAssets/1298-2487-animated-icon-set-1-color.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
      title: "Home",
      route: Homepage()),
  RiveAsset("assets/RiveAssets/1298-2487-animated-icon-set-1-color.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      title: "Search",
      route: login()),
  RiveAsset("assets/RiveAssets/1298-2487-animated-icon-set-1-color.riv",
      artboard: "LIKE/STAR",
      stateMachineName: "STAR_Interactivity",
      title: "Favorite",
      route: MyWidget()),
];

List<RiveAsset> sideMenues2 = [
  RiveAsset("assets/RiveAssets/1298-2487-animated-icon-set-1-color.riv",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
      title: "History",
      route: "home"),
  RiveAsset("assets/RiveAssets/1298-2487-animated-icon-set-1-color.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
      title: "Notification",
      route: "login"),
];
