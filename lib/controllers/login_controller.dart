import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/models/user.dart';

const List<String> scopes = <String>[
  'email',
  'openid',
  'profile',
];

class LoginController extends GetxController {
  LoggedInUser currentUser = Pref.loggedInUser;
  GoogleSignInAccount? authUser;
  GoogleSignIn googleSign = GoogleSignIn(
    scopes: scopes,
  );

  Future<void> signIn() async {
    try {
      authUser = await googleSign.signIn();
      if (authUser != null) {
        Map<String, dynamic> loggedInUser = {
          'id': 1,
          "google_id": authUser?.id,
          "name": authUser?.displayName,
          "email": authUser?.email,
          "accessToken": "access_token",
          "isPremium": true,
          "isLoggedIn": true
        };

        http.Response response = await http.post(
          Uri.parse('http://mojhavpn.com/user'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(loggedInUser),
        );

        final dbUser = UserApi.fromJson(jsonDecode(response.body)['user']);

        loggedInUser = {
          'id': dbUser.id,
          "google_id": dbUser.googleId,
          "name": dbUser.name,
          "email": dbUser.email,
          "accessToken": dbUser.accessToken,
          "isPremium": dbUser.isPremium,
          "isLoggedIn": true
        };

        Pref.loggedInUser = LoggedInUser.fromJson(loggedInUser);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> signOut() async {
    try {
      await googleSign.signOut();
      Map<String, dynamic> loggedInUser = {
        'id': 0,
        "google_id": "",
        "name": "",
        "email": "",
        "accessTokne": "",
        "isPremium": false,
        "isLoggedIn": false
      };
      Pref.loggedInUser = LoggedInUser.fromJson(loggedInUser);
    } catch (error) {
      print(error);
    }
  }
}
