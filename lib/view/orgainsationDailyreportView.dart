import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pooleye/controller/lifeguardNotificationController.dart';
import 'package:pooleye/controller/lifeguardReportController.dart';
import 'package:pooleye/controller/medicalReportController.dart';
import 'package:pooleye/database/firebase.dart';
import 'package:pooleye/model/lifeguardReport.dart';
import 'package:pooleye/model/medicReport.dart';
import 'package:pooleye/model/notification.dart';
import 'package:pooleye/view/appMenuView.dart';
import 'package:provider/provider.dart';

class daily_report extends StatefulWidget {
  String something;
  daily_report(this.something);
  @override
  daily createState() => daily(this.something);
}

class daily extends State<daily_report> {
  String something;
  daily(this.something);
  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  List reports = [
    'Drowning Case At Swimming Pool No.3   "Time:09:57 PM"',
    'Drowning Case At Swimming Pool No.1   "Time:11:02 PM"',
    'Drowning Case At Swimming Pool No.4   "Time:02:15 PM"',
    'Drowning Case At Swimming Pool No.1   "Time: 03:06 PM"'
  ];

  GetFirebase color = GetFirebase();

  // showReport() {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Center(
  //             child: Text(
  //               "Full Report",
  //               style: TextStyle(fontSize: 30.0, color: Colors.blueAccent),
  //             ),
  //           ),
  //           content: Container(
  //             height: 250,
  //             width: 250,
  //             child: Column(
  //               children: [
  //                 Container(
  //                   color: Colors.indigoAccent,
  //                   width: 250,
  //                   height: 60,
  //                   child: Column(
  //                     children: [
  //                       new Padding(padding: new EdgeInsets.all(5.0)),
  //                       Text(
  //                         "Status: ",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, color: Colors.white),
  //                       ),
  //                       Text(
  //                         "Get An Ambulance",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.yellow),
  //                       ),
  //                       new Padding(padding: new EdgeInsets.all(5.0)),
  //                     ],
  //                   ),
  //                 ),
  //                 new Padding(padding: new EdgeInsets.all(15.0)),
  //                 Container(
  //                   color: Colors.indigoAccent,
  //                   width: 250,
  //                   height: 60,
  //                   child: Column(
  //                     children: [
  //                       new Padding(padding: new EdgeInsets.all(5.0)),
  //                       Text(
  //                         "Lifeguard Notes: ",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, color: Colors.white),
  //                       ),
  //                       Text(
  //                         "Need An Ambulance Now !",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.yellow),
  //                       ),
  //                       new Padding(padding: new EdgeInsets.all(5.0)),
  //                     ],
  //                   ),
  //                 ),
  //                 new Padding(padding: new EdgeInsets.all(15.0)),
  //                 Container(
  //                   color: Colors.indigoAccent,
  //                   width: 250,
  //                   height: 60,
  //                   child: Column(
  //                     children: [
  //                       new Padding(padding: new EdgeInsets.all(5.0)),
  //                       Text(
  //                         "Medical Team Notes: ",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, color: Colors.white),
  //                       ),
  //                       Text(
  //                         "Patient is in hospital and stable.",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.yellow),
  //                       ),
  //                       new Padding(padding: new EdgeInsets.all(5.0)),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  // #enddocregion RWS-var

  // #docregion _buildSuggestions
  Widget _buildChatList(GlobalKey<ScaffoldState> key) {
    if (something == "lifeguard") {
      print("Lifeguard");
      List<LifeguardReport> notiList = [];
      List<LifeguardReport> orgList =
          Provider.of<List<LifeguardReport>>(context);

      if (orgList != null) {
        orgList.forEach((element) {
          if (element.orgId == 'Ahlyclub49301616522931404') {
            notiList.add(element);
          }
        });
      }
      return (notiList != null)
          ? Container(
              child: ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemBuilder: /*1*/ (context, i) {
                  return _buildRow(notiList[i].comment, notiList[i].date, key,
                      notiList[i].type);
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: notiList.length,
              ),
            )
          : Text('Loading');
    }

    if (something == "medic") {
      print("medic");

      List<MedicReport> notiList = [];
      List<MedicReport> orgList = Provider.of<List<MedicReport>>(context);

      if (orgList != null) {
        orgList.forEach((element) {
          if (element.orgId == 'Ahlyclub49301616522931404') {
            notiList.add(element);
          }
        });
      }
      return (notiList != null)
          ? Container(
              child: ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemBuilder: /*1*/ (context, i) {
                  return _buildRow(notiList[i].comment, notiList[i].date, key,
                      "Submitted by Lifeguard");
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: notiList.length,
              ),
            )
          : Text('Loading');
    }
    // List<MedicReport> notiList = [];
    // List<MedicReport> orgList = Provider.of<List<MedicReport>>(context);

    // if (orgList != null) {
    //   orgList.forEach((element) {
    //     if (element.orgId == 'Ahlyclub49301616522931404') {
    //       notiList.add(element);
    //     }
    //   });
    // }
  }
  // #enddocregion _buildSuggestions

  // #docregion _buildRow
  Widget _buildRow(String name, Timestamp date, GlobalKey<ScaffoldState> key,
      [String type]) {
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
        "status: " + type + "\n" "Comment: " + name,
        style: TextStyle(
          color: Colors.red.withOpacity(0.8),
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text("Sent At: " + date.toDate().toString()),
      trailing: IconButton(
        icon: Icon(Icons.receipt_rounded),
        onPressed: () {
          //showReport();
        },
      ),
      onTap: () {
        //showReport();
      },
      isThreeLine: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldKey,
        drawer: SideDrawer('organisationManager'),
        appBar: AppBar(
          title: Row(
            children: [
              Text('The Daily Reports '),
              Image.asset(
                'images/report.png',
                fit: BoxFit.cover,
                width: 35,
              ),
            ],
          ),
          backgroundColor: c1,
        ),
        body: _buildChatList(_scaffoldKey),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: c1,
          items: [
            BottomNavigationBarItem(
              title: Text(
                'Lifeguard Report',
                style: TextStyle(
                    color:
                        color.getcolor == true ? Colors.white : Colors.black),
              ),
              icon: Icon(
                Icons.pool,
                color: color.getcolor == true ? Colors.white : Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              title: Text(
                'Medic Report',
                style: TextStyle(
                    color:
                        color.getcolor == false ? Colors.white : Colors.black),
              ),
              icon: Icon(
                Icons.local_hospital_sharp,
                color: color.getcolor == false ? Colors.white : Colors.black,
              ),
            ),
          ],
          elevation: 5.0,
          onTap: (index) {
            setState(() {
              if (index == 0) {
                color.color = true;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuilddailyReportList('lifeguard'),
                  ),
                  (Route<dynamic> route) => false, // remove back arrow
                );
              } else {
                color.color = false;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuilddailyReportList('medic'),
                  ),
                  (Route<dynamic> route) => false, // remove back arrow
                );
              }
            });
          },
        ));
  }
}

class BuilddailyReportList extends StatefulWidget {
  String something;
  BuilddailyReportList(this.something);
  @override
  _BuilddailyReportListState createState() =>
      _BuilddailyReportListState(this.something);
}

class _BuilddailyReportListState extends State<BuilddailyReportList> {
  String something;
  _BuilddailyReportListState(this.something);
  MedicReportController LFN = MedicReportController();
  LifeguardReportController LFC = LifeguardReportController();
  Stream<List<MedicReport>> val;
  Stream<List<LifeguardReport>> val2;
  @override
  void initState() {
    if (something == 'lifeguard') {
      LFC.fetchLifeguardReports().then((value) {
        val2 = LFC.lifeguardreport;

        setState(() {});
      });
    }

    if (something == 'medic') {
      LFN.fetchMedicReports().then((value) {
        val = LFN.medicreport;

        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return StreamProvider<List<LifeguardReport>>.value(
    //     value: val2, child: daily_report());
    if (something == 'lifeguard') {
      return StreamProvider<List<LifeguardReport>>.value(
          value: val2, child: daily_report('lifeguard'));
    }
    if (something == 'medic') {
      return StreamProvider<List<MedicReport>>.value(
          value: val, child: daily_report('medic'));
    }
  }
}
