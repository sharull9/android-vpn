import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpn_basic_project/models/user.dart';

import '../models/vpn.dart';

class Pref {
  static late Box _box;

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('data');
  }

  //for storing theme data
  static bool get isDarkMode => _box.get('isDarkMode') ?? false;
  static set isDarkMode(bool v) => _box.put('isDarkMode', v);

  //for storing single selected vpn details
  static Vpn get vpn => Vpn.fromJson(jsonDecode(_box.get('vpn') ?? '{}'));
  static set vpn(Vpn v) => _box.put('vpn', jsonEncode(v));

  //for storing vpn servers details
  static List<Vpn> get vpnList {
    List<Vpn> temp = [];
    final data = jsonDecode(_box.get('vpnList') ?? '[]');
    for (var i in data) temp.add(Vpn.fromJson(i));
    return temp;
  }

  static set vpnList(List<Vpn> v) => _box.put('vpnList', jsonEncode(v));

  static LoggedInUser get loggedInUser {
    const returnData = {
      "id": 0,
      "google_id": "",
      "isLoggedIn": false,
      "name": "",
      "email": "",
      "accessToken": "",
      "isPremium": false,
    };
    return LoggedInUser.fromJson(
        jsonDecode(_box.get('loggedInUser') ?? jsonEncode(returnData)));
  }

  static set loggedInUser(LoggedInUser v) =>
      _box.put('loggedInUser', jsonEncode(v));
}
