import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/helpers/ad_helper.dart';
import 'package:vpn_basic_project/helpers/config.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';
import 'package:vpn_basic_project/screens/network_test_screen.dart';
import 'package:vpn_basic_project/widgets/watch_ad_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          padding: EdgeInsets.only(right: 8),
          onPressed: () => Get.to(() => HomeScreen()),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 8),
            onPressed: () {
              if (Config.hideAds) {
                Get.to(() => NetworkTestScreen());
                return;
              }
              Get.dialog(WatchAdDialog(onComplete: () {
                //watch ad to gain reward
                AdHelper.showRewardedAd(onComplete: () {
                  Get.to(() => NetworkTestScreen());
                });
              }));
            },
            icon: Icon(
              CupertinoIcons.info,
              size: 27,
            ),
          ),
        ],
      ),
    );
  }
}
