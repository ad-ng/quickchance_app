import 'package:quickchance_app/features/auth/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserPreferences {
  // Save user to SharedPreferences
  Future<void> saveLocalUser(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = json.encode(
      user.toJson(),
    ); // Convert UserModel to JSON string
    await prefs.setString('user', userJson); // Save the JSON string
  }

  // Get user from SharedPreferences
  Future<UserModel?> getLocalUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      return UserModel.fromJson(
        json.decode(userJson),
      ); // Convert JSON string back to UserModel
    }
    return null; // Return null if no user data found
  }

  // Remove the user from SharedPreferences
  Future<void> removeLocalUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
