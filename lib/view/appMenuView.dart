import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pooleye/controller/lifeguardController.dart';
import 'package:pooleye/controller/organizationManagerController.dart';
import 'package:pooleye/model/lifeguard.dart';
import 'package:pooleye/services/loginAuth.dart';
import 'package:pooleye/view/generatedOrgCodeView.dart';
import 'package:pooleye/view/lifeguardNotificationView.dart';
import 'package:pooleye/view/lifeguardProfileView.dart';
import 'package:pooleye/view/medicalNotificationView.dart';
import 'package:pooleye/view/orgAccountBottomBar.dart';
import 'package:provider/provider.dart';
import 'package:pooleye/controller/medicController.dart';

class SideDrawer extends StatefulWidget {
  @override
  String router;
  SideDrawer(this.router);

  _SideDrawerState createState() => _SideDrawerState(this.router);
}

class _SideDrawerState extends State<SideDrawer> {
  String router;
  _SideDrawerState(this.router);
  Lifeguard passNotification = Lifeguard();
  @override
  Color c2 = const Color.fromRGBO(110, 204, 234, 1.0);
  bool isSwitched = true;
  var textValue = 'Switch is ON';
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
        //passNotification.update("1");
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
        //passNotification.update("0");
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (router == 'organisationManager') {
      return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  'Organisation Manager Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              decoration: BoxDecoration(
                color: c2,
              ),
            ),
            ListTile(
              leading: Icon(Icons.receipt_rounded),
              title: Text('Organisation Daily Reports'),
              onTap: () => {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => BuilddailyReportList('lifeguard')),
                // )
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box_rounded),
              title: Text('All Organisation Accounts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrgAccountsBar(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Organisation Profile'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<OrganizationMangerprovider>(
                                create: (_) => OrganizationMangerprovider(),
                                child: Profile("org"))));
              },
            ),
            ListTile(
              leading: Icon(Icons.copy_rounded),
              title: Text('Organisation Code'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<OrganizationMangerprovider>(
                              create: (_) => OrganizationMangerprovider(),
                              child: GeneratedCode())),
                );
              },
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AuthFormLogin()),
                    (Route<dynamic> route) => false, // remove back arrow
                  );
                }),
          ],
        ),
      );
    }

    if (router == 'lifeguard') {
      return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  'Lifeguard Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              decoration: BoxDecoration(
                color: c2,
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications_active),
              title: Text('Lifeguard Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuildList()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.pool),
              title: Text('Lifeguard Profile'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<Lifeguardprovider>(
                                create: (_) => Lifeguardprovider(),
                                child: Profile("lifeguard"))));
              },
            ),
            ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                ),
                title: Text('Logout'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AuthFormLogin()),
                    (Route<dynamic> route) => false, // remove back arrow
                  );
                }),
          ],
        ),
      );
    }

    if (router == 'medic') {
      return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  'Medic Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              decoration: BoxDecoration(
                color: c2,
              ),
            ),
            ListTile(
              leading: Icon(Icons.local_hospital_outlined),
              title: Text('Medic Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuildReportList()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Medic Profile'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<Medicprovider>(
                                create: (_) => Medicprovider(),
                                child: Profile("medic"))));
              },
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AuthFormLogin()),
                    (Route<dynamic> route) => false, // remove back arrow
                  );
                }),
          ],
        ),
      );
    }
    return Container();
  }
}
