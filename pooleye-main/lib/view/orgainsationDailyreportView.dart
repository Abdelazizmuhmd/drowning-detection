import 'package:flutter/material.dart';
import 'package:pooleye/view/appMenuView.dart';

class daily_report extends StatefulWidget {
  @override
  daily createState() => daily();
}

class daily extends State<daily_report> {
  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  List reports = [
    'Drowning Case At Swimming Pool No.3   "Time:09:57 PM"',
    'Drowning Case At Swimming Pool No.1   "Time:11:02 PM"',
    'Drowning Case At Swimming Pool No.4   "Time:02:15 PM"',
    'Drowning Case At Swimming Pool No.1   "Time: 03:06 PM"'
  ];
  showReport() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Full Report",
                style: TextStyle(fontSize: 30.0, color: Colors.blueAccent),
              ),
            ),
            content: Container(
              height: 250,
              width: 250,
              child: Column(
                children: [
                  Container(
                    color: Colors.indigoAccent,
                    width: 250,
                    height: 60,
                    child: Column(
                      children: [
                        new Padding(padding: new EdgeInsets.all(5.0)),
                        Text(
                          "Status: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "Get An Ambulance",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow),
                        ),
                        new Padding(padding: new EdgeInsets.all(5.0)),
                      ],
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(15.0)),
                  Container(
                    color: Colors.indigoAccent,
                    width: 250,
                    height: 60,
                    child: Column(
                      children: [
                        new Padding(padding: new EdgeInsets.all(5.0)),
                        Text(
                          "Lifeguard Notes: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "Need An Ambulance Now !",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow),
                        ),
                        new Padding(padding: new EdgeInsets.all(5.0)),
                      ],
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(15.0)),
                  Container(
                    color: Colors.indigoAccent,
                    width: 250,
                    height: 60,
                    child: Column(
                      children: [
                        new Padding(padding: new EdgeInsets.all(5.0)),
                        Text(
                          "Medical Team Notes: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "Patient is in hospital and stable.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow),
                        ),
                        new Padding(padding: new EdgeInsets.all(5.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  // #enddocregion RWS-var

  // #docregion _buildSuggestions
  Widget _buildChatList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        return _buildRow(reports[i]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: reports.length,
    );
  }
  // #enddocregion _buildSuggestions

  // #docregion _buildRow
  Widget _buildRow(String name) {
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
        icon: Icon(Icons.receipt_rounded),
        onPressed: () {
          showReport();
        },
      ),
      onTap: () {
        showReport();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
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
      body: _buildChatList(),
    );
  }
}
