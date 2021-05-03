import 'package:flutter/material.dart';
import 'package:pooleye/database/firebase.dart';
import 'package:pooleye/model/notification.dart';
import 'package:pooleye/view/appMenuView.dart';
import 'package:pooleye/model/lifeguardReport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:provider/provider.dart";
import "package:pooleye/controller/lifeguardReportController.dart";
import "package:pooleye/controller/lifeguardNotificationController.dart";
import "package:pooleye/controller/lifeguardController.dart";
import "package:pooleye/database/firebase.dart";

class lifeguard_notify extends StatefulWidget {
  @override
  var LFN;
  lifeguard_notify({this.LFN});
  lifeguard createState() => lifeguard(LFN: LFN);
}

class lifeguard extends State<lifeguard_notify> {
  List lgList;
  int userIndex;
  bool isSwitched;
  void initState() {
    Provider.of<Lifeguardprovider>(this.context, listen: false)
        .fetchdata()
        .then((value) {
      prog = false;
    });
    super.initState();
  }

  var LFN;
  lifeguard({this.LFN});
  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  var prog = true;

  final _formKey = GlobalKey<FormState>();

  LifeguardReportController LFC = LifeguardReportController();

  showReport({String id, bool sent}) {
    var _commentField = new TextEditingController();
    var _typeField = new TextEditingController();
    bool visibe_third_button = false;
    bool visibe_second_button = false;
    bool visibe_first_button = false;
    String type = null;
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Center(
                  child: Column(
                children: [
                  Text(
                    "Send A Report",
                    style: TextStyle(fontSize: 20.0, color: Colors.blueAccent),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 10,
                    thickness: 2,
                    indent: 110,
                    endIndent: 110,
                  ),
                  SizedBox(
                    height: 35,
                  ),
                ],
              )),
              content: Container(
                height: 300,
                width: 350,
                child: ListView(
                  children: [
                    Text(
                      "Choose The Drowning Status  \n",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              !visibe_first_button
                                  ? new SizedBox(
                                      height: 65,
                                      child: RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            visibe_first_button = true;
                                            visibe_second_button = false;
                                            visibe_third_button = false;
                                            _typeField.text = "False Alarm";
                                            type = "False Alarm";
                                          });
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('False Alert',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        color: Colors.red,
                                      ))
                                  : new SizedBox(
                                      height: 65,
                                      child: RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            visibe_first_button = false;
                                            _typeField.text = null;
                                            type = null;
                                          });
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('False Alert',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        color: Colors.red,
                                      )),
                              Visibility(
                                  visible: visibe_first_button,
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        ),

                        SizedBox(width: 10), // set a space between buttons

                        Expanded(
                          child: Column(
                            children: [
                              !visibe_second_button
                                  ? new SizedBox(
                                      height: 65,
                                      child: RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            visibe_second_button = true;
                                            visibe_first_button = false;
                                            visibe_third_button = false;
                                            _typeField.text = 'CPR';
                                            type = 'CPR';
                                          });
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Need CPR',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        color: Colors.red,
                                      ))
                                  : new SizedBox(
                                      height: 65,
                                      child: RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            visibe_second_button = false;
                                            _typeField.text = null;
                                            type = null;
                                          });
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Need CPR',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        color: Colors.red,
                                      )),
                              Visibility(
                                  visible: visibe_second_button,
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        ),

                        SizedBox(width: 10), // set a space between buttons

                        Expanded(
                          child: Column(
                            children: [
                              !visibe_third_button
                                  ? new SizedBox(
                                      height: 65,
                                      child: RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            visibe_third_button = true;
                                            visibe_first_button = false;
                                            visibe_second_button = false;
                                            _typeField.text = 'Get Ambulance';
                                            type = 'Get Ambulance';
                                          });
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Get',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white)),
                                            Icon(
                                              Icons.local_hospital_rounded,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                        color: Colors.red,
                                      ))
                                  : new SizedBox(
                                      height: 65,
                                      child: RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            visibe_third_button = false;
                                            _typeField.text = null;
                                            type = null;
                                          });
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Get',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white)),
                                            Icon(
                                              Icons.local_hospital_rounded,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                        color: Colors.red,
                                      )),
                              Visibility(
                                  visible: visibe_third_button,
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Visibility(
                                visible: false,
                                child: TextFormField(
                                  controller: _typeField,
                                  /*validator: (value) {
                                      if (value == null) {
                                        return 'Please choose a type';
                                      }
                                      if (value.isEmpty) {
                                        return 'Please choose a type';
                                      }
                                      return null;
                                    }*/
                                )),
                            TextFormField(
                              controller: _commentField,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Your Comment';
                                }
                                if (type != "False Alarm" && (type == null)) {
                                  return 'Please choose a type';
                                }
                                if (type != "Get Ambulance" && (type == null)) {
                                  return "Please enter Your comment";
                                }
                                if (type != "CPR" && (type == null)) {
                                  return "Please enter Your comment";
                                }
                                if (_typeField.text.isEmpty) {
                                  return 'Please choose a type';
                                }
                                return null;
                              },
                              decoration: new InputDecoration(
                                hintText: 'Comment',
                                icon: new Icon(Icons.comment),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false
                                // otherwise.
                                if (_formKey.currentState.validate()) {
                                  //If the form is valid, Go to Home screen.
                                  LFC.addLifeguardReport(
                                      type: type,
                                      id: id,
                                      comment: _commentField.text,
                                      orgId: lgList[userIndex].orgCode);
                                  LFN.updateSent(id);

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
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
  // #enddocregion RWS-var

  // #docregion _buildSuggestions
  _buildChatList(GlobalKey<ScaffoldState> key) {
    List<LifeguardNotification> notiList = [];
    List<LifeguardNotification> orgList =
        Provider.of<List<LifeguardNotification>>(context);
    (orgList != null)
        ? orgList.forEach((element) {
            if (element.orgId == lgList[userIndex].orgCode) {
              notiList.add(element);
            }
          })
        : print('test');

    return (notiList != null)
        ? Container(
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemBuilder: /*1*/ (context, i) {
                return _buildRow(
                    notiList[i].text, notiList[i].id, notiList[i].sent, key);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: notiList.length,
            ),
          )
        : Text("Loading");
  }
  // #enddocregion _buildSuggestions

  // #docregion _buildRow
  _buildRow(String name, String id, bool sent, GlobalKey<ScaffoldState> key) {
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
        icon: Icon(Icons.send_and_archive),
        onPressed: () {
          if (!sent) {
            showReport(id: id, sent: sent);
          } else {
            key.currentState
              ..showSnackBar(SnackBar(
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
          showReport(id: id, sent: sent);
        } else {
          key.currentState
            ..showSnackBar(SnackBar(
              content: Text(
                'Report already added for this case!',
              ),
              duration: Duration(seconds: 2),
            ));
        }
      },
    );
  }

  void updateSwitch() {
    if (lgList.length > 0) {
      if (lgList[userIndex].switcher == true)
        isSwitched = true;
      else
        isSwitched = false;
    }
  }

  void toggleSwitch(bool value) {
    LFC.updatesubscriber(GetFirebase().getUserID, value);

    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        lgList[userIndex].switcher = true;
      });
    } else {
      setState(() {
        isSwitched = false;
        lgList[userIndex].switcher = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    lgList =
        Provider.of<Lifeguardprovider>(this.context, listen: true).lifeguard;
    userIndex =
        lgList.indexWhere((element) => element.id == GetFirebase().getUserID);
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    //if (prog == false) isSwitched = lgList[userIndex].switcher;
    updateSwitch();
    return prog
        ? CircularProgressIndicator()
        : Scaffold(
            key: _scaffoldKey,
            drawer: SideDrawer('lifeguard'),
            appBar: AppBar(
              title: Row(
                children: [
                  Text('Lifeguard Notifications '),
                  Icon(
                    Icons.notifications_active_rounded,
                    color: Colors.yellow,
                  ),
                  isSwitched == null
                      ? CircularProgressIndicator()
                      : Switch(
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showReport();
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
            ),
          );
  }
}

class BuildList extends StatefulWidget {
  @override
  _BuildListState createState() => _BuildListState();
}

class _BuildListState extends State<BuildList> {
  LifeguardNotificationController LFN = LifeguardNotificationController();
  //LifeguardReportController LFC = LifeguardReportController();
  Stream<List<LifeguardNotification>> val;
  @override
  void initState() {
    LFN.fetchLifeguardReports().then((value) {
      val = LFN.lifeguardnotification;

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<LifeguardNotification>>.value(
        value: val,
        child: ChangeNotifierProvider<Lifeguardprovider>(
            create: (_) => Lifeguardprovider(),
            child: lifeguard_notify(LFN: LFN)));
  }
}
