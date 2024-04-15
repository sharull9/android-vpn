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
  RxBool isLoggedIn = Pref.isLoggedIn.obs;
  RxBool isPremium = Pref.isPremium.obs;
  RxDouble expiredAt = Pref.expiredAt.obs;
  String accessToken = Pref.accessToken;
  final RxBool isLoading = false.obs;
  User loggedUser = Pref.user;

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
          "Authorization": "Bearer " + Config.accessToken,
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
        isPremium = user['is_premium'];
        accessToken = user['access_token'];
        loggedUser = User.fromJson(user);
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
        final body = {
          "name": googleUser!.displayName,
          "email": googleUser!.email,
          "google_id": googleUser!.id,
        };
        final userResponse = await post(
          Uri.parse(ApiRoutes.google(googleUser!.id)),
          headers: {
            "Authorization": "Bearer " + Config.accessToken,
          },
          body: body,
        );
        final response = jsonDecode(userResponse.body);
        final user = response['user'];
        if (response['error'] == false) {
          signIn();
          accessToken = user['access_token'];
          isPremium = user['is_premium'];
          loggedUser = User.fromJson(user);
        } else {
          MyDialogs.error(msg: response['message']);
        }
      }

    } catch (error) {
      MyDialogs.error(msg: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkAccessTokenExpiry() async {
    if (isLoggedIn.value == true &&
        expiredAt.value + (216000 * 24) >
            DateTime.now().millisecondsSinceEpoch / 1000) {
      try {
        final response = await get(
          Uri.parse(ApiRoutes.refreshToken),
          headers: {
            "Authorization": "Bearer " + loggedUser.accessToken,
          },
        );
        final result = jsonDecode(response.body);
        if (result['error'] == true) {
          accessToken = Config.accessToken;
        } else {
          accessToken = result['access_token'];
        }
      } catch (error) {
        MyDialogs.error(msg: error.toString());
      }
    }
  }

  void signIn() {
    expiredAt.value = DateTime.now().millisecondsSinceEpoch / 1000;
    isLoggedIn.value = true;
  }

  signOut() {
    loggedUser = User.fromJson({});
    isLoggedIn.value = false;
  }
}
