import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpn_basic_project/helpers/config.dart';
import 'package:vpn_basic_project/models/server.dart';
import 'package:vpn_basic_project/models/location.dart';
import 'package:vpn_basic_project/models/user.dart';

class Pref {
  static late Box _box;

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('data');
  }

  static bool get isDarkMode => _box.get('isDarkMode') ?? false;
  static set isDarkMode(bool v) => _box.put('isDarkMode', v);

  static bool get isLoggedIn => _box.get('isLoggedIn') ?? false;
  static set isLoggedIn(bool v) => _box.put('isLoggedIn', v);

  static bool get isPremium => _box.get('isPremium') ?? false;
  static set isPremium(bool v) => _box.put('isPremium', v);

  static String get accessToken =>
      _box.get('accessToken') ?? Config.accessToken;
  static set accessToken(String v) => _box.put('accessToken', v);

  static double get expiredAt =>
      _box.get('expiredAt') ?? DateTime.now().millisecondsSinceEpoch / 1000;
  static set expiredAt(double v) => _box.put('expiredAt', v);

  static User get user => User.fromJson(jsonDecode(_box.get('user') ?? '{}'));
  static set user(User u) => _box.put('user', jsonEncode(u));

  static Location get location =>
      Location.fromJson(jsonDecode(_box.get('location') ?? '{}'));
  static set location(Location l) => _box.put('location', jsonEncode(l));

  static Server get server =>
      Server.fromJson(jsonDecode(_box.get('server') ?? '{}'));
  static set server(Server s) => _box.put('server', jsonEncode(s));

  static set locationList(List<Location> v) =>
      _box.put('locationList', jsonEncode(v));

  static List<Location> get locationList {
    List<Location> temp = [];
    final data = jsonDecode(_box.get('locationList') ?? '[]');
    for (var i in data) temp.add(Location.fromJson(i));
    return temp;
  }
}
