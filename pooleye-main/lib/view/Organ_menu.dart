import 'package:flutter/material.dart';
import 'package:pooleye/view/OrganizationProfile.dart';
import 'package:pooleye/view/lifeguardProfile.dart';
import 'package:pooleye/view/lifeguard_notifications.dart';
import 'package:pooleye/view/login.dart';
import 'package:pooleye/view/medicProfile.dart';
import 'package:pooleye/view/medic_notifications.dart';
import 'package:pooleye/view/organ_accounts.dart';

class SideDrawer extends StatelessWidget {
  @override
  Color c2 = const Color.fromRGBO(110, 204, 234, 1.0);
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Account',
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
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Colors.blueGrey,
            height: 15,
            thickness: 2,
            indent: 0,
            endIndent: 50,
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
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Colors.blueGrey,
            height: 15,
            thickness: 2,
            indent: 0,
            endIndent: 50,
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
}
