import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../main.dart';
import '../models/vpn_new.dart';
import '../services/vpn_engine.dart';

class NewVpnCard extends StatelessWidget {
  final VpnNew vpn;

  const NewVpnCard({super.key, required this.vpn});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: mq.height * .01),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () {
            // controller.vpn.value = vpn;
            // Pref.vpn = vpn;
            Get.back();
            if (controller.vpnState.value == VpnEngine.vpnConnected) {
              VpnEngine.stopVpn();
              Future.delayed(
                  Duration(seconds: 2), () => controller.connectToVpn());
            } else {
              controller.connectToVpn();
            }
          },
          borderRadius: BorderRadius.circular(15),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            leading: Container(
              padding: EdgeInsets.all(.5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                    'assets/flags/${vpn.countryShort.toLowerCase()}.png',
                    height: 40,
                    width: mq.width * .15,
                    fit: BoxFit.cover),
              ),
            ),
            title: Text("Text"),
            subtitle: Row(
              children: [
                Icon(Icons.bar_chart, color: Colors.blue, size: 20),
                SizedBox(width: 4),
                Text(vpn.ping, style: TextStyle(fontSize: 13))
              ],
            ),
          ),
        ));
  }
}
