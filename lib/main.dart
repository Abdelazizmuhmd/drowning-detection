import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pooleye/services/loginAuth.dart';
import 'package:pooleye/view/SplashScreenView.dart';
import 'package:pooleye/view/lifeguardNotificationView.dart';
import 'package:pooleye/view/medicalNotificationView.dart';
import 'package:pooleye/view/orgainsationDailyreportView.dart';
import 'package:provider/provider.dart';

import 'controller/organizationManagerController.dart';

void main() => runApp(
      MyApp(),
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => MyApp(), // Wrap your app
      // ),
    );

class MyApp extends StatefulWidget {
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
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
                      if (userSnapshot.hasData) {
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(userSnapshot.data.uid)
                            .snapshots()
                            .listen((event) {
                          var userRole = event.get("role");

                          if (userRole == "organisationManager") {
                            return Navigator.pushAndRemoveUntil(
                              ctx,
                              MaterialPageRoute(
                                  builder: (ctx) => ChangeNotifierProvider<
                                          OrganizationMangerprovider>(
                                      create: (_) =>
                                          OrganizationMangerprovider(),
                                      child:
                                          BuilddailyReportList('lifeguard'))),
                              (Route<dynamic> route) =>
                                  false, // remove back arrow
                            );
                          }

                          if (userRole == "lifeguard") {
                            return Navigator.pushAndRemoveUntil(
                              ctx,
                              MaterialPageRoute(builder: (ctx) => BuildList()),
                              (Route<dynamic> route) =>
                                  false, // remove back arrow
                            );
                          }

                          if (userRole == "medic") {
                            return Navigator.pushAndRemoveUntil(
                              ctx,
                              MaterialPageRoute(
                                  builder: (ctx) => BuildReportList()),
                              (Route<dynamic> route) =>
                                  false, // remove back arrow
                            );
                          }
                        });
                      } else {
                        return AuthFormLogin();
                      }

                      return SplashScreen();
                    }),
          );
        });
  }
}
