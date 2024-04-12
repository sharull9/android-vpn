import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vpn_basic_project/controllers/auth_controller.dart';
import 'package:vpn_basic_project/screens/login_screen.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: ((context, user, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: Center(
            child: Column(
              children: [
                Text(user.name),
                Text("Name"),
                ElevatedButton(
                  onPressed: () async {
                    await Provider.of<Auth>(context, listen: false).signOut();
                    Get.to(() => LoginScreen());
                  },
                  child: Text('Sign out'),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
