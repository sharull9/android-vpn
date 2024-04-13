import 'package:get/get.dart';
import 'package:vpn_basic_project/models/location.dart';

import '../apis/apis.dart';
import '../helpers/pref.dart';

class LocationController extends GetxController {
  List<Location> vpnLocation = Pref.locationList;
  final RxBool isLoading = false.obs;

  Future<void> getVPNLocation() async {
    isLoading.value = true;
    vpnLocation = await APIs.getVPNLocations();
    isLoading.value = false;
  }
}
