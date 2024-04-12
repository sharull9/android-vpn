import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vpn_basic_project/controllers/auth_controller.dart';
import 'package:vpn_basic_project/firebase_options.dart';

import 'helpers/ad_helper.dart';
import 'helpers/config.dart';
import 'helpers/pref.dart';
import 'screens/splash_screen.dart';

//global object for accessing device screen size
late Size mq;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Config.initConfig();
  await Pref.initializeHive();
  await AdHelper.initAds();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (v) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => Auth()),
          ],
          child: MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GetMaterialApp(
      title: 'OpenVpn Demo',
      home: const SplashScreen(),
      // routes: {
      //   '/sign-in': (context) {
      //     return SignInScreen(
      //       providers: [
      //         EmailAuthProvider(),
      //         GoogleProvider(
      //             clientId:
      //                 "8820423924-pqf3hqlh6bh2u7a166dchlst8l1eit12.apps.googleusercontent.com")
      //       ],
      //       actions: [
      //         AuthStateChangeAction<SignedIn>((context, state) {
      //           Navigator.pushReplacementNamed(context, '/profile');
      //         }),
      //       ],
      //     );
      //   },
      //   '/profile': (context) {
      //     return ProfileScreen(
      //       providers: [
      //         EmailAuthProvider(),
      //         GoogleProvider(
      //             clientId:
      //                 "8820423924-pqf3hqlh6bh2u7a166dchlst8l1eit12.apps.googleusercontent.com")
      //       ],
      //       actions: [
      //         SignedOutAction((context) {
      //           Navigator.pushReplacementNamed(context, '/sign-in');
      //         }),
      //       ],
      //     );
      //   },
      // },
      //theme
      theme: ThemeData(
        appBarTheme: AppBarTheme(centerTitle: true, elevation: 3),
      ),
      themeMode: Pref.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 3,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

extension AppTheme on ThemeData {
  Color get lightText => Pref.isDarkMode ? Colors.white70 : Colors.black54;
  Color get bottomNav => Pref.isDarkMode ? Colors.white12 : Colors.blue;
}
