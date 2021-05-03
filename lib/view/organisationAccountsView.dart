import 'package:flutter/material.dart';
import 'package:pooleye/controller/lifeguardController.dart';

import 'package:pooleye/model/lifeguard.dart';
import 'package:pooleye/view/orgAccountBottomBar.dart';
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
                return Card(
                  color: Colors.cyan.shade600,
                  child: ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        Text(" " + lifeguard[index].getemail,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        Text(" " + lifeguard[index].getusername,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Center(
                                  child: Text("Confirm Delete"),
                                ),
                                content: Text("Are You Sure Want To Proceed ?"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("YES"),
                                    onPressed: () {
                                      update.updateData(lifeguard[index].getId,
                                          {'deleted': deleted});

                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("CANCEL"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
    );
  }
}
