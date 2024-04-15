import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/helpers/my_dialogs.dart';
import 'package:vpn_basic_project/models/location.dart';

import '../controllers/home_controller.dart';
import '../helpers/pref.dart';
import '../main.dart';
import '../services/vpn_engine.dart';

class LocationCard extends StatelessWidget {
  final Location location;

  const LocationCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: mq.height * .01),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          controller.location.value = location;

          if (location.category == "PREMIUM" && Pref.isPremium == false) {
            return MyDialogs.info(msg: 'Please Upgrade Your Plan');
          }

          Pref.location = location;
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

          //flag
          leading: Container(
            padding: EdgeInsets.all(.5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(5)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/flags/${location.countryCode.toLowerCase()}.png',
                height: 40,
                width: mq.width * .15,
                fit: BoxFit.cover,
              ),
            ),
          ),

          //title
          title: Text(location.cityName),

          //subtitle
          subtitle: Row(
            children: [
              Icon(Icons.speed_rounded, color: Colors.blue, size: 20),
              SizedBox(width: 4),
            ],
          ),

          //trailing
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 4),
              Text(
                location.category == 'FREE' ? 'Free' : "Premium",
                style: TextStyle(
                  color: location.category == 'FREE'
                      ? Colors.black54
                      : Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
