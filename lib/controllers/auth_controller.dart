import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/helpers/api_routes.dart';
import 'package:vpn_basic_project/helpers/config.dart';
import 'package:vpn_basic_project/helpers/my_dialogs.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/models/user.dart';

const List<String> scopes = <String>[
  'email',
  'openid',
  'profile',
];

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  String accessToken =
      Pref.accessToken.isEmpty ? Config.accessToken : Pref.accessToken;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: Config.googleClientId,
    scopes: Config.logInScopes,
  );
  GoogleSignInAccount? googleUser;

  Future<void> createUser({
    required String name,
    required String email,
    googleId,
    password,
  }) async {
    isLoading.value = true;
    try {
      final body = {
        'name': name,
        'email': email,
        'google_id': googleId,
        'password': password,
      };
      final response = await post(
        Uri.parse(ApiRoutes.createUser),
        headers: {},
        body: jsonEncode(body),
      );
      final result = jsonDecode(response.body);
      if (result['error'] == true) {
        MyDialogs.error(msg: result['message']);
      }
    } catch (error) {
      MyDialogs.error(msg: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> credentail(String email, String password) async {
    try {
      isLoading.value = true;
      final body = {'email': email, 'password': password};
      final response = await post(
        Uri.parse(ApiRoutes.login),
        headers: {
          "Authorization": "Bearer " + accessToken,
        },
        body: jsonEncode(body),
      );
      final result = jsonDecode(response.body);
      if (result['error'] == false) {
        final userResponse = await get(
          Uri.parse(ApiRoutes.user),
          headers: {
            "Authorization": "Bearer " + result['access_token'],
          },
        );
        final user = jsonDecode(userResponse.body)['user'];
        Pref.isPremium = user['is_premium'];
        Pref.accessToken = user['access_token'];
        Pref.user = User.fromJson(user);
        signIn();
      } else {
        MyDialogs.error(msg: result['message']);
      }
    } catch (error) {
      MyDialogs.error(msg: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> google() async {
    try {
      googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final userDetails = {
          "name": googleUser!.displayName,
          "email": googleUser!.email,
          "google_id": googleUser!.id,
        };
        final userResponse = await post(
          Uri.parse(ApiRoutes.google),
          headers: {
            "Authorization": "Bearer " + accessToken,
          },
          body: jsonEncode(userDetails),
        );
        final response = jsonDecode(userResponse.body);
        final user = response['user'];
        if (response['error'] == false) {
          signIn();
          Pref.accessToken = user['access_token'];
          Pref.isPremium = user['is_premium'];
          Pref.user = User.fromJson(user);
          Pref.avatar = googleUser!.photoUrl!;
        } else {
          MyDialogs.error(msg: response['message']);
        }
      }
      signIn();
    } catch (error) {
      MyDialogs.error(msg: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkAccessTokenExpiry() async {
    if (Pref.isLoggedIn == true &&
        Pref.expiredAt + (216000 * 24) >
            DateTime.now().millisecondsSinceEpoch / 1000) {
      try {
        final response = await get(
          Uri.parse(ApiRoutes.refreshToken),
          headers: {
            "Authorization": "Bearer " + accessToken,
          },
        );
        final result = jsonDecode(response.body);
        if (result['error'] == true) {
          Pref.accessToken = Config.accessToken;
        } else {
          Pref.accessToken = result['access_token'];
        }
      } catch (error) {
        MyDialogs.error(msg: error.toString());
      }
    }
  }

  void signIn() {
    Pref.expiredAt = DateTime.now().millisecondsSinceEpoch / 1000;
    Pref.isLoggedIn = true;
  }

  void signOut() async {
    Pref.user = User.fromJson({});
    Pref.avatar = "";
    if (Pref.avatar.isEmpty) {
      googleUser = await _googleSignIn.signOut();
    }
    Pref.isLoggedIn = false;
  }
}
