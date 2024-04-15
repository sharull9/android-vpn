import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

import '../helpers/ad_helper.dart';
import '../main.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      AdHelper.precacheInterstitialAd();
      AdHelper.precacheNativeAd();
      Get.off(() => HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: mq.width * .3,
            top: mq.height * .2,
            width: mq.width * .4,
            child: Image.asset('assets/images/logo.png'),
          ),
          Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            child: Text(
              'MADE IN INDIA WITH ❤️',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).lightText,
                letterSpacing: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
