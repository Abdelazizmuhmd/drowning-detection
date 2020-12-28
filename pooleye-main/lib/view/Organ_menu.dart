import 'package:flutter/material.dart';
import 'package:pooleye/view/OrganizationProfile.dart';
import 'package:pooleye/view/login.dart';
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
            title: Text('Daily Reports'),
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
            title: Text('Profile'),
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
}
