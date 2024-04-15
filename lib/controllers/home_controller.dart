import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/helpers/api_routes.dart';
import 'package:vpn_basic_project/helpers/config.dart';
import 'package:vpn_basic_project/models/server.dart';
import 'package:vpn_basic_project/models/location.dart';

import '../helpers/ad_helper.dart';
import '../helpers/my_dialogs.dart';
import '../helpers/pref.dart';
import '../models/vpn_config.dart';
import '../services/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<Location> location = Pref.location.obs;
  final Rx<Server> server = Pref.server.obs;
  final vpnState = VpnEngine.vpnDisconnected.obs;

  void connectToVpn() async {
    final response = await get(
      Uri.parse(ApiRoutes.bestServer(location.value.id)),
      headers: {
        "Authorization": 'Bearer ' + Config.accessToken,
      },
    );
    server.value = Server.fromJson(jsonDecode(response.body));
    if (server.value.configData.isEmpty) {
      MyDialogs.info(msg: 'Select a Location by clicking \'Change Location\'');
      return;
    }

    if (vpnState.value == VpnEngine.vpnDisconnected) {
      final vpnConfig = VpnConfig(
        country: location.value.cityName,
        username: server.value.username,
        password: server.value.password,
        config: Utf8Decoder().convert(
          Base64Decoder().convert(server.value.configData),
        ),
      );
      AdHelper.showInterstitialAd(
        onComplete: () async {
          await VpnEngine.startVpn(vpnConfig);
        },
      );
    } else {
      await VpnEngine.stopVpn();
    }
  }

  Color get getButtonColor {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return Colors.blue;
      case VpnEngine.vpnConnected:
        return Colors.green;
      default:
        return Colors.orangeAccent;
    }
  }

  String get getButtonText {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return 'Tap to Connect';
      case VpnEngine.vpnConnected:
        return 'Disconnect';
      default:
        return 'Connecting...';
    }
  }
}
