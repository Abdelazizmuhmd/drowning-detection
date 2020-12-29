import 'package:flutter/material.dart';
import 'package:pooleye/model/lifeguard_notifiactions.dart';
import 'package:pooleye/view/Organ_menu.dart';

class lifeguard_notify extends StatefulWidget {
  @override
  lifeguard createState() => lifeguard();
}

class lifeguard extends State<lifeguard_notify> {
  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  final lifeGuard_notify all_notifications = lifeGuard_notify();
  bool visibe_third_button = false;
  bool visibe_second_button = false;
  bool visibe_first_button = false;
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
                  "Send A Report",
                  style: TextStyle(fontSize: 20.0, color: Colors.blueAccent),
                ),
              ),
              content: Container(
                height: 250,
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
                            TextFormField(
                              controller: _commentField,
                              validator: (value) {
                                // if (value.isEmpty) {
                                //   return 'Please enter Your Password';
                                // }
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
  Widget _buildChatList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        return _buildRow(all_notifications.getLifeguardNotifiactions()[i]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: all_notifications.getLifeguardNotifiactions().length,
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
        icon: Icon(Icons.send_and_archive),
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
            Text('Lieguard Notifications '),
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
