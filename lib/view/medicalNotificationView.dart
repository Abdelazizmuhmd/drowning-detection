import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pooleye/view/appMenuView.dart';
import "package:provider/provider.dart";
import "package:pooleye/controller/lifeguardReportController.dart";
import 'package:pooleye/model/lifeguardReport.dart';
import "package:pooleye/controller/medicalReportController.dart";

import '../controller/medicalReportController.dart';
import '../controller/medicalReportController.dart';
import "package:pooleye/controller/medicController.dart";
import "package:pooleye/database/firebase.dart";

class medic_notify_page extends StatefulWidget {
  @override
  var LFC;
  medic_notify_page({this.LFC});
  medic createState() => medic(LFC: LFC);
}

class medic extends State<medic_notify_page> {
  var medicList;
  int userIndex;
  var prog = true;
  void initState() {
    Provider.of<Medicprovider>(this.context, listen: false)
        .fetchdata()
        .then((value) {
      prog = false;
    });
    super.initState();
  }

  var LFC;
  medic({this.LFC});
  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  final _formKey = GlobalKey<FormState>();

  MedicReportController MRC = new MedicReportController();

  showReport(String id, String name, String type) {
    var _commentField = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Center(
                child: Text(
                  "Send A Full Report",
                  style: TextStyle(fontSize: 20.0, color: Colors.blueAccent),
                ),
              ),
              content: Container(
                height: 300,
                width: 350,
                child: Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Status: \n",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            type,
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Lifeguard Notes: \n",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _commentField,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Your comment';
                                    }
                                    return null;
                                  },
                                  decoration: new InputDecoration(
                                    hintText: 'Medic Notes',
                                    icon: new Icon(Icons.comment),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false
                                    // otherwise.
                                    if (_formKey.currentState.validate()) {
                                      MRC.addMedicReport(
                                          id: id,
                                          comment: _commentField.text,
                                          orgId: medicList[userIndex].orgCode);
                                      LFC.updateSent(id);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text('Send'),
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
  // #enddocregion RWS-var

  // #docregion _buildSuggestions
  Widget _buildChatList(GlobalKey<ScaffoldState> key) {
    List<LifeguardReport> reportList = [];
    List<LifeguardReport> orgList = Provider.of<List<LifeguardReport>>(context);
    (orgList != null)
        ? orgList.forEach((element) {
            if (element.orgId == medicList[userIndex].orgCode) {
              reportList.add(element);
            }
          })
        : print('test');
    return (reportList != null)
        ? Container(
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemBuilder: /*1*/ (context, i) {
                return _buildRow(reportList[i].comment, reportList[i].id,
                    reportList[i].sent, key, reportList[i].type);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: reportList.length,
            ),
          )
        : Text('Loading');
  }
  // #enddocregion _buildSuggestions

  // #docregion _buildRow
  Widget _buildRow(String name, String id, bool sent,
      GlobalKey<ScaffoldState> key, String type) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Row(
          children: <Widget>[
            Image.asset(
              'images/4.jpg',
              height: 30,
            ),
          ],
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          color: Colors.red.withOpacity(0.8),
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.message_outlined,
          color: Colors.redAccent,
        ),
        onPressed: () {
          if (!sent) {
            showReport(id, name, type);
          } else {
            key.currentState.showSnackBar(SnackBar(
              content: Text(
                'Report already added for this case!',
              ),
              duration: Duration(seconds: 2),
            ));
          }
        },
      ),
      onTap: () {
        if (!sent) {
          showReport(id, name, type);
        } else {
          key.currentState.showSnackBar(SnackBar(
            content: Text(
              'Report already added for this case!',
            ),
            duration: Duration(seconds: 2),
          ));
        }
      },
    );
  }

  bool isSwitched = true;

  void toggleSwitch(bool value) {
    LFC.updatesubscriber(GetFirebase().getUserID, value);

    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    medicList = Provider.of<Medicprovider>(this.context, listen: true).medic;
    userIndex = medicList
        .indexWhere((element) => element.id == GetFirebase().getUserID);
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideDrawer('medic'),
      appBar: AppBar(
        title: Row(
          children: [
            Text('Medic Notifications '),
            Icon(
              Icons.notifications_active_rounded,
              color: Colors.yellow,
            ),
            Switch(
              onChanged: toggleSwitch,
              value: isSwitched,
              activeColor: Colors.blue,
              activeTrackColor: Colors.grey,
              inactiveThumbColor: Colors.redAccent,
              inactiveTrackColor: Colors.grey,
            ),
          ],
        ),
        backgroundColor: c1,
      ),
      body: _buildChatList(_scaffoldKey),
    );
  }
}

class BuildReportList extends StatefulWidget {
  @override
  _BuildReportListState createState() => _BuildReportListState();
}

class _BuildReportListState extends State<BuildReportList> {
  LifeguardReportController LFC = LifeguardReportController();
  Stream<List<LifeguardReport>> val;
  @override
  void initState() {
    LFC.fetchLifeguardReports().then((value) {
      val = LFC.lifeguardreport;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<LifeguardReport>>.value(
        value: val,
        child: ChangeNotifierProvider<Medicprovider>(
            create: (_) => Medicprovider(),
            child: medic_notify_page(LFC: LFC)));
  }
}
