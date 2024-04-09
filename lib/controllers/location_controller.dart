import 'package:get/get.dart';

import '../apis/apis.dart';
import '../helpers/pref.dart';
import '../models/vpn.dart';

class LocationController extends GetxController {
  List<Vpn> vpnList = Pref.vpnList;

  final RxBool isLoading = false.obs;

  Future<void> getVpnData() async {
    isLoading.value = true;
    vpnList.clear();
    vpnList = await APIs.getVPNServers();
    isLoading.value = false;
  }

  // List<VpnNew> newVpnList = Pref.newVpnList;

  final RxBool newIsLoading = false.obs;

  // Future<void> newGetVpnData() async {
  //   isLoading.value = true;
  //   newVpnList.clear();
  //   newVpnList = await APIs.getNewVPNServers();
  //   isLoading.value = false;
  // }
}
