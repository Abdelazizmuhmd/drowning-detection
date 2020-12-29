import 'package:flutter/material.dart';
import 'package:pooleye/model/lifeguard_notifiactions.dart';
import 'package:pooleye/model/medic_notifications.dart';
import 'package:pooleye/view/Organ_menu.dart';

class medic_notify_page extends StatefulWidget {
  @override
  medic createState() => medic();
}

class medic extends State<medic_notify_page> {
  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  final medic_notify all_notifications = medic_notify();

  final _formKey = GlobalKey<FormState>();
  var _commentField = new TextEditingController();

  showReport() {
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
                height: 250,
                width: 350,
                child: Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Status: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Get An Ambulance",
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
                        "Need an Ambulance Now !",
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
                                    // if (value.isEmpty) {
                                    //   return 'Please enter Your Password';
                                    // }
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
                                      //If the form is valid, Go to Home screen.
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => daily_report()),
                                      // );

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
  Widget _buildChatList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        return _buildRow(all_notifications.getMedicNotifications()[i]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: all_notifications.getMedicNotifications().length,
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
        icon: Icon(
          Icons.message_outlined,
          color: Colors.redAccent,
        ),
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
      appBar: AppBar(
        title: Row(
          children: [
            Text('Medic Notifications '),
            Icon(
              Icons.notifications_active_rounded,
              color: Colors.yellow,
            ),
          ],
        ),
        backgroundColor: c1,
      ),
      body: _buildChatList(),
    );
  }
}
