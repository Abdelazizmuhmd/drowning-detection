import 'package:flutter/material.dart';
import 'package:pooleye/model/notification.dart';
import 'package:pooleye/view/appMenuView.dart';
import 'package:pooleye/model/lifeguardReport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:provider/provider.dart";
import "package:pooleye/controller/lifeguardReportController.dart";
import "package:pooleye/controller/lifeguardNotificationController.dart";

class lifeguard_notify extends StatefulWidget {
  @override
  lifeguard createState() => lifeguard();
}

class lifeguard extends State<lifeguard_notify> {
  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);

  final _formKey = GlobalKey<FormState>();
  var _commentField = new TextEditingController();
  var _typeField = new TextEditingController();
  LifeguardReportController LFC = LifeguardReportController();

  showReport({String orgId, bool sent}) {
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
                child: Text(
                  "Send A Report",
                  style: TextStyle(fontSize: 20.0, color: Colors.blueAccent),
                ),
              ),
              content: Container(
                height: 320,
                width: 350,
                child: Column(
                  children: [
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
                                          children: [
                                            Text('False Alarm',
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
                                print(_typeField.text);
                                print(type == 'CPR');
                                // Validate returns true if the form is valid, or false
                                // otherwise.
                                if (_formKey.currentState.validate()) {
                                  //If the form is valid, Go to Home screen.
                                  LFC.addLifeguardReport(
                                      type: type,
                                      id: orgId,
                                      comment: _commentField.text);
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
  _buildChatList() {
    List<LifeguardNotification> notiList = [];
    List<LifeguardNotification> orgList =
        Provider.of<List<LifeguardNotification>>(context);
    orgList.forEach((element) {
      if (element.orgId == 'Ahlyclub49301616522931404') {
        notiList.add(element);
      }
    });

    return (notiList != null)
        ? Container(
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemBuilder: /*1*/ (context, i) {
                return _buildRow(
                    notiList[i].text, notiList[i].orgId, notiList[i].sent);
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
  _buildRow(String name, String orgId, bool sent) {
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
          showReport(orgId: orgId, sent: sent);
        },
      ),
      onTap: () {
        showReport(orgId: orgId, sent: sent);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer('lifeguard'),
      appBar: AppBar(
        title: Row(
          children: [
            Text('Lifeguard Notifications '),
            Icon(
              Icons.notifications_active_rounded,
              color: Colors.yellow,
            ),
          ],
        ),
        backgroundColor: c1,
      ),
      body: _buildChatList(),
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
        value: val, child: lifeguard_notify());
  }
}
