import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vpn_basic_project/controllers/auth_controller.dart';
import 'package:vpn_basic_project/controllers/login_controller.dart';
import 'package:vpn_basic_project/helpers/ad_helper.dart';
import 'package:vpn_basic_project/helpers/config.dart';
import 'package:vpn_basic_project/screens/network_test_screen.dart';
import 'package:vpn_basic_project/screens/signup_screen.dart';
import 'package:vpn_basic_project/screens/user_profile_screen.dart';
import 'package:vpn_basic_project/widgets/watch_ad_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisibility = true;

  final _controller = LoginController();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildBody(Auth user) {
    return Consumer<Auth>(
      builder: (context, user, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Log in',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
              child: Text(
                'Let\'s get started by filling out the form below.',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: emailController,
                        autofocus: true,
                        autofillHints: [AutofillHints.email],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.black),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black45,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        minLines: null,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: passwordController,
                        autofocus: true,
                        obscureText: passwordVisibility,
                        autofillHints: [AutofillHints.password],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black),
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black45,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: InkWell(
                            onTap: () => setState(
                              () => passwordVisibility = !passwordVisibility,
                            ),
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              !passwordVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Color(0xFF57636C),
                              size: 24,
                            ),
                          ),
                        ),
                        minLines: null,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await Provider.of<Auth>(context, listen: false)
                                .signIn(
                              emailController.text.toString(),
                              passwordController.text.toString(),
                            );
                            Get.to(() => UserProfileScreen());
                          } catch (e) {
                            log(e.toString());
                          }
                        }
                      },
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size.fromHeight(40)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(color: Colors.black45)),
                          shadowColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: Text(
                        "Sign in",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
              child: Container(
                width: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional(0, 0),
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                        child: Container(
                          width: double.infinity,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Container(
                        width: 70,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'OR',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _controller.signIn();
                },
                style: ButtonStyle(
                    // maximumSize: MaterialStateProperty.all<Size>(Size.infinite),
                    minimumSize:
                        MaterialStateProperty.all<Size>(Size.fromHeight(40)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.black45)),
                    shadowColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                child: Text(
                  "Sign in with Google",
                  style: TextStyle(color: Colors.black),
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t Have Account? ',
                  style: TextStyle(color: Colors.black),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Get.to(() => SignupScreen()),
                  child: Text(
                    'Create an Account',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (context, user, _) {
      return GestureDetector(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(CupertinoIcons.back),
                padding: EdgeInsets.only(right: 8),
                onPressed: () {
                  Get.back();
                }),
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
                  )),
            ],
          ),
          key: scaffoldKey,
          backgroundColor: Colors.black,
          body: SafeArea(
            top: true,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    width: 100,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    alignment: AlignmentDirectional(0, -1),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxWidth: 430,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildBody(user),
                                    // Obx(() => _buildBody()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
