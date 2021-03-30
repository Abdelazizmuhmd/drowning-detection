import 'package:flutter/material.dart';
import 'package:pooleye/controller/lifeguardController.dart';
import 'package:pooleye/controller/medicController.dart';
import 'package:pooleye/view/medicorgallAccounts.dart';
import 'package:pooleye/view/organisationAccountsView.dart';
import 'package:provider/provider.dart';

class OrgAccountsBar extends StatefulWidget {
  @override
  _OrgAccountsBarState createState() => _OrgAccountsBarState();
}

class _OrgAccountsBarState extends State<OrgAccountsBar> {
  int selectedPage = 0;

  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  final _pageOptions = [
    ChangeNotifierProvider<Lifeguardprovider>(
      create: (_) => Lifeguardprovider(),
      child: OrgAccountslifeguard(),
    ),
    ChangeNotifierProvider<Medicprovider>(
      create: (_) => Medicprovider(),
      child: OrgAccountsmedic(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _pageOptions[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: c1,
          items: [
            BottomNavigationBarItem(
              title: Text(
                'Lifeguards Account',
              ),
              icon: Icon(Icons.pool),
            ),
            BottomNavigationBarItem(
              title: Text(
                'Medic Accounts',
              ),
              icon: Icon(Icons.local_hospital),
            ),
          ],
          selectedItemColor: Colors.white,
          elevation: 5.0,
          unselectedItemColor: Colors.black,
          currentIndex: selectedPage,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
        ));
  }
}
