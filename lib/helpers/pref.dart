import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
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

  static bool get loggedIn => _box.get('loggedIn') ?? false;
  static set loggedIn(bool v) => _box.put('loggedIn', v);

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
