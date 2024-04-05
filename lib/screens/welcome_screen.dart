import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';
import 'package:vpn_basic_project/screens/login_screen.dart';
import 'package:vpn_basic_project/screens/signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Expanded(
                flex: 6,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: EdgeInsetsDirectional.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onTap: () => Get.to(() => HomeScreen()),
                          child: Text(
                            'Skip',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () => Get.to(() => SignupScreen()),
                                style: ButtonStyle(
                                    // maximumSize: MaterialStateProperty.all<Size>(Size.infinite),
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                            Size.fromHeight(40)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    side: MaterialStateProperty.all<BorderSide>(
                                        BorderSide(color: Colors.black45)),
                                    shadowColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white)),
                                child: Text(
                                  "Signup",
                                  style: TextStyle(color: Colors.black),
                                )),
                            ElevatedButton(
                                onPressed: () => Get.to(() => LoginScreen()),
                                style: ButtonStyle(
                                    // maximumSize: MaterialStateProperty.all<Size>(Size.infinite),
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                            Size.fromHeight(40)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    side: MaterialStateProperty.all<BorderSide>(
                                        BorderSide(color: Colors.black45)),
                                    shadowColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white)),
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        )
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
