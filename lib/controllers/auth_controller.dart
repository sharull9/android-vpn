import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vpn_basic_project/models/auth_user.dart';
import '../helpers/my_dialogs.dart';

class Auth extends ChangeNotifier {
  String domain = "http://mojhavpn.com/";
  String name = "";
  String email = "";
  String role = "";
  String accessToken = "";
  bool isPremium = false;
  bool loggedIn = false;
  DateTime expiresAt = DateTime.now();

  Future<void> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("http://mojhavpn.com/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      String token = jsonDecode(response.body)['access_token'];

      final userResponse = await http
          .get(Uri.parse("http://mojhavpn.com/user"), headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      });
      User user = User.fromJson(jsonDecode(userResponse.body));

      name = user.name;
      email = user.email;
      role = user.role;
      accessToken = user.accessToken;
      isPremium = user.isPremium;
      loggedIn = true;
      expiresAt = DateTime.now();

      notifyListeners();
    } catch (e) {
      MyDialogs.error(msg: e.toString());
      log(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      name = "";
      email = "";
      role = "";
      accessToken = "";
      isPremium = false;
      loggedIn = false;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signInGoogle(String googleId, String name, String email) async {
    late User user;
    final response = await http.post(
      Uri.parse("$domain/create-user"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'name': name,
        'google_id': googleId
      }),
    );
    final responseBody = jsonDecode(response.body);
    if (responseBody['error'] == false) {
      user = User.fromJson(responseBody['user']);
    } else if (responseBody['error'] == true &&
        responseBody['message'].toString().contains("User already exists")) {
      final userResponse = await http.get(
        Uri.parse("$domain/user/google/$googleId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      user = User.fromJson(jsonDecode(userResponse.body));
    }
    name = user.name;
    email = user.email;
    role = user.role;
    accessToken = user.accessToken;
    isPremium = user.isPremium;
    loggedIn = true;
    expiresAt = DateTime.now();

    notifyListeners();
  }
}
