import 'package:flutter/material.dart';

class OrgAccounts extends StatefulWidget {
  _OrgAccounts createState() => _OrgAccounts();
}

class _OrgAccounts extends State<OrgAccounts> {
  List allAccounts = [
    'Alahlymedicalteam@pooleye.com',
    'dr.ali@pooleye.com',
    'Ahmed.alysw.1@pooleye.com',
    'Ashraf.ahmedsw.2@pooley.com',
    'Aly.ziadsw.3@pooleye.com'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: Text("All Organization Accounts"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color.fromRGBO(110, 204, 234, 1.0),
      ),
      body: _accounts(),
    );
  }

  Widget _accounts() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: allAccounts.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${allAccounts[index]}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  icon: Icon(Icons.delete), color: Colors.red, onPressed: () {})
            ],
          ),
          height: 50,
          color: Colors.cyan,
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
