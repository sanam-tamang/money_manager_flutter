import 'package:shared_preferences/shared_preferences.dart';

class UserDB {
  static void setUsername(String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('username', username);
  }

  static Future<String?>? getUsername() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? username = sharedPreferences.getString('username');
    return username;
  }

    static void deleteUsername() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   sharedPreferences.remove('username');
    
  }
}
