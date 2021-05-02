import 'package:flutter/material.dart';
import 'package:pooleye/controller/medicController.dart';

import 'package:pooleye/model/medic.dart';
import 'package:provider/provider.dart';

class OrgAccountsmedic extends StatefulWidget {
  _OrgAccountsmedic createState() => _OrgAccountsmedic();
}

class _OrgAccountsmedic extends State<OrgAccountsmedic> {
  List<Medic> medic;

  bool prog = true;
  var update;
  int deleted = 1;
  @override
  void initState() {
    Provider.of<Medicprovider>(this.context, listen: false)
        .fetchdata()
        .then((value) {
      prog = false;
    });
    update = Provider.of<Medicprovider>(this.context, listen: false);

    super.initState();
  }

  Widget build(BuildContext context) {
    medic = Provider.of<Medicprovider>(this.context, listen: true).medic;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: Text("All Medic Accounts"),
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
              itemCount: medic.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        medic[index].getemail,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
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
                                  content:
                                      Text("Are You Sure Want To Proceed ?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("YES"),
                                      onPressed: () {
                                        update.updateData(medic[index].getId,
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
