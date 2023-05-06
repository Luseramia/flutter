import 'package:shared_preferences/shared_preferences.dart';

class user {
  static Future<bool?> getsignin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("Signin");
  }

  static Future setsingin(bool singin) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("Signin", singin);
  }

  //PI = personal information
  static Future setEmail(String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("email", email);
  }

  static Future<String?> getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("email");
  }

  static Future clearEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('email');
  }
}
