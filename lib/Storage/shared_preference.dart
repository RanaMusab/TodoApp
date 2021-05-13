import 'package:shared_preferences/shared_preferences.dart';

/// a class that exchanges data with shared preferences
class SharedPrefClient {
  Future<void> setUser(
      {String name, String id, int age, String email, String token}) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('name', name);
    await sharedPref.setString('_id', id);
    await sharedPref.setInt('age', age);
    await sharedPref.setString('email', email);
    await sharedPref.setString('token', token);
    await sharedPref.setInt("initScreen", 2);
  }
  Future<void> clearUser() async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('name', null);
    await sharedPref.setString('_id', null);
    await sharedPref.setInt('age', 0);
    await sharedPref.setString('email', null);
    await sharedPref.setString('token', null);
    await sharedPref.setInt("initScreen", 1);
  }
}
