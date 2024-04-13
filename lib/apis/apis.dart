import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/helpers/api_routes.dart';
import 'package:vpn_basic_project/models/location.dart';

import '../helpers/my_dialogs.dart';
import '../helpers/pref.dart';
import '../models/ip_details.dart';

class APIs {
  static Future<void> getIPDetails({required Rx<IPDetails> ipData}) async {
    try {
      final res = await get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(res.body);
      log(data.toString());
      ipData.value = IPDetails.fromJson(data);
    } catch (e) {
      MyDialogs.error(msg: e.toString());
      log('\ngetIPDetailsE: $e');
    }
  }

  static Future<List<Location>> getVPNLocations() async {
    late List<Location> vpnList = [];
    try {
      final res = await get(Uri.parse(ApiRoutes.location),
          headers: {"Authorization": "Bearer " + ApiRoutes.token});
      final body = jsonDecode(res.body);

      for (int i = 0; i < body['free'].length; ++i) {
        vpnList.add(Location.fromJson(body['free'][i]));
      }
      for (int i = 0; i < body['premium'].length; ++i) {
        vpnList.add(Location.fromJson(body['premium'][i]));
      }
      if (vpnList.isNotEmpty) Pref.locationList = vpnList;
    } catch (e) {
      MyDialogs.error(msg: e.toString());
      log('\ngetIPDetailsE: $e');
    }
    return vpnList;
  }
}
