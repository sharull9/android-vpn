import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:vpn_basic_project/controllers/auth_controller.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/models/user.dart';

const List<String> scopes = <String>[
  'email',
  'openid',
  'profile',
];

class LoginController {
  GoogleSignInAccount? authUser;
  GoogleSignIn googleSign = GoogleSignIn(
    scopes: scopes,
  );

  Future<void> signIn() async {
    try {
      authUser = await googleSign.signIn();
      if (authUser != null) {
        await Auth().signInGoogle(
          authUser!.id,
          authUser!.displayName!,
          authUser!.email,
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> signOut() async {
    try {
      await googleSign.signOut();
      await Auth().signOut();
    } catch (error) {
      print(error);
    }
  }
}
