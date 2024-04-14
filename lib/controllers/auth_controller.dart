import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/helpers/api_routes.dart';
import 'package:vpn_basic_project/helpers/my_dialogs.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/models/user.dart';

const List<String> scopes = <String>[
  'email',
  'openid',
  'profile',
];

class AuthController extends GetxController {
  RxBool loggedIn = Pref.loggedIn.obs;
  final RxBool isLoading = false.obs;
  User loggedUser = Pref.user;

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
        headers: {},
        body: jsonEncode(body),
      );
      final result = jsonDecode(response.body);
      if (result['error'] == false) {
        final userResponse = await get(
          Uri.parse(ApiRoutes.user),
          headers: {"Authorization": "Bearer " + result['access_token']},
        );
        final user = jsonDecode(userResponse.body)['user'];
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

  Future<void> google(String email, String googleId) async {
    try {
      final userResponse = await get(Uri.parse(ApiRoutes.google(googleId)));
      final response = jsonDecode(userResponse.body);
      final user = response['user'];
      if (response['error'] == false) {
        signIn();
        loggedUser = User.fromJson(user);
      } else {
        MyDialogs.error(msg: response['message']);
      }
    } catch (error) {
      MyDialogs.error(msg: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  signIn() {
    loggedIn.value = true;
  }

  signOut() {
    loggedUser = User.fromJson({});
    loggedIn.value = false;
  }
}
