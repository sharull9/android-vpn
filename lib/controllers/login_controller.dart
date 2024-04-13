import 'package:get/get.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/models/user.dart';

const List<String> scopes = <String>[
  'email',
  'openid',
  'profile',
];

class LoginController extends GetxController {
  RxBool loggedIn = Pref.loggedIn.obs;
  Future<void> credentail(String email, String password) async {
    try {
      // signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> google(String googleId) async {
    try {
      // signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> signIn(User user) async {
    try {
      loggedIn.value = true;
    } catch (error) {
      print(error);
    }
  }

  Future<void> signOut() async {
    try {
      loggedIn.value = false;
    } catch (error) {
      print(error);
    }
  }
}
