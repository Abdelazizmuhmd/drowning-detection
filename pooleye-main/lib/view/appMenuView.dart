import 'package:flutter/material.dart';
import 'package:pooleye/view/OrganizationProfileView.dart';
import 'package:pooleye/view/lifeguardNotificationView.dart';
import 'package:pooleye/view/lifeguardProfileView.dart';
import 'package:pooleye/view/loginView.dart';
import 'package:pooleye/view/medicProfileView.dart';
import 'package:pooleye/view/medicalNotificationView.dart';
import 'package:pooleye/view/organisationAccountsView.dart';

class SideDrawer extends StatelessWidget {
  String router;
  SideDrawer(this.router);

  @override
  Color c2 = const Color.fromRGBO(110, 204, 234, 1.0);
  Widget build(BuildContext context) {
    if (router == 'organisationManager') {
      return Drawer(
        child: Column(
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
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.account_box_rounded),
              title: Text('All Organisation Accounts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrgAccounts()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Organisation Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrgProfile()),
                );
              },
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                }),
          ],
        ),
      );
    }

    if (router == 'lifeguard') {
      return Drawer(
        child: Column(
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
                  MaterialPageRoute(builder: (context) => lifeguard_notify()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.pool),
              title: Text('Lifeguard Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => lifeguardProfile()),
                );
              },
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                }),
          ],
        ),
      );
    }

    if (router == 'medic') {
      return Drawer(
        child: Column(
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
                  MaterialPageRoute(builder: (context) => medic_notify_page()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Medic Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => medicProfile()),
                );
              },
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                }),
          ],
        ),
      );
    }
    return Container();
  }
}
