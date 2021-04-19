import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pooleye/services/loginAuth.dart';
import 'package:pooleye/view/SplashScreenView.dart';

void main() => runApp(
      MyApp(),
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => MyApp(), // Wrap your app
      // ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //GetFirebase userData = new GetFirebase();

    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
            title: 'Pooleye App',
            debugShowCheckedModeBanner: false,
            home: appSnapshot.connectionState != ConnectionState.done
                ? SplashScreen()
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SplashScreen();
                      }

                      // if (userSnapshot.hasData) {
                      //   return HomePage('');
                      // }
                      // if (userSnapshot.hasData &&
                      //     userData.getRole == "organisationManager") {
                      //   return daily_report();
                      // }

                      // if (userSnapshot.hasData &&
                      //     userData.getRole == "lifeguard") {
                      //   return BuildList();
                      // }

                      // if (userSnapshot.hasData && userData.getRole == "medic") {
                      //   return medic_notify_page();

                      return AuthFormLogin();
                    }),
          );
        });
  }
}
