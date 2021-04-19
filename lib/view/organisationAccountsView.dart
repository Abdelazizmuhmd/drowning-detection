import 'package:flutter/material.dart';
import 'package:pooleye/controller/lifeguardController.dart';

import 'package:pooleye/model/lifeguard.dart';
import 'package:provider/provider.dart';

class OrgAccountslifeguard extends StatefulWidget {
  _OrgAccountslifeguard createState() => _OrgAccountslifeguard();
}

class _OrgAccountslifeguard extends State<OrgAccountslifeguard> {
  List<Lifeguard> lifeguard;

  bool prog = true;
  var update;
  int deleted = 1;
  @override
  void initState() {
    Provider.of<Lifeguardprovider>(this.context, listen: false)
        .fetchdata()
        .then((value) {
      prog = false;
    });
    update = Provider.of<Lifeguardprovider>(this.context, listen: false);
    super.initState();
  }

  Widget build(BuildContext context) {
    lifeguard =
        Provider.of<Lifeguardprovider>(this.context, listen: true).lifeguard;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: Text("All Lifeguards Accounts"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color.fromRGBO(110, 204, 234, 1.0),
      ),
      body: prog
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: lifeguard.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        lifeguard[index].getemail,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            update.updateData(
                                lifeguard[index].getId, {'deleted': deleted});
                            Navigator.of(context).pop();
                          })
                    ],
                  ),
                  height: 50,
                  color: Colors.cyan,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
    );
  }
}
