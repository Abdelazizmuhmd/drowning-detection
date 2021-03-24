import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class medicProfile extends StatefulWidget {
  static Pattern pattern;
  _medicProfile createState() => _medicProfile();
}

class _medicProfile extends State<medicProfile> {
  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  TextFormField test;
  static final validCharacters = RegExp(r"^[a-zA-Z]+$");
  final _formKey = GlobalKey<FormState>();
  TextEditingController _customController;
  //Userprovider userOn = new Userprovider();

  createAlertDialog(BuildContext context, String type, String val) {
    _customController = new TextEditingController(text: val);
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("Your $type"),
              content: Container(
                height: 370,
                width: 550,
                child: Form(
                  key: _formKey,
                  child: type == "No."
                      ? Column(
                          children: [
                            MaterialButton(
                              elevation: 5.0,
                              child: Text('Submit'),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  // If the form is valid, Go to Home screen.
                                }
                              },
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (type == "Password") {
                                  if (value.isEmpty) {
                                    return 'Please Enter Last Name';
                                  }
                                  if (value.length < 3) {
                                    return 'Last Name is too short';
                                  }

                                  if (value.length > 18) {
                                    return 'Last Name is too long';
                                  }
                                  if (!validCharacters.hasMatch(value)) {
                                    return 'Last Name should be alphabets only';
                                  }
                                  return null;
                                }
                              },
                              controller: _customController,
                            ),
                            MaterialButton(
                              elevation: 5.0,
                              child: Text('Submit'),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  // If the form is valid, Go to Home screen.
                                }
                              },
                            )
                          ],
                        ),
                ),
              ),
            );
          });
        });
  }

  Widget textfield({@required String hintText, String type}) {
    return Material(
        elevation: 4,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Form(
          child: Stack(children: [
            test = TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  hintText: type == "No."
                      ? "Number of swimming Pools is $hintText"
                      : hintText,
                  hintStyle: TextStyle(
                    letterSpacing: 2,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                  fillColor: Colors.white30,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none)),
            ),
            Row(children: [
              Container(
                padding: EdgeInsets.only(left: 310, top: 10),
                child: IconButton(
                  icon:
                      type == "Logout" ? Icon(Icons.logout) : Icon(Icons.edit),
                  onPressed: () {
                    if (type == "Logout")
                      print("logout");
                    else
                      createAlertDialog(context, type, hintText);
                  },
                ),
              )
            ])
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: Text("lifeguard Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color.fromRGBO(110, 204, 234, 1.0),
      ),
      body: ListView(children: [
        Stack(alignment: Alignment.topCenter, children: [
          Container(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      //padding: EdgeInsets.all(0.0),
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5),
                          shape: BoxShape.circle,
                          color: Colors.blueAccent.withOpacity(0.2),
                          image: DecorationImage(
                              image: AssetImage("images/doctor.jpg"))),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 140,
                          left: MediaQuery.of(context).size.width / 2.2),
                      margin: EdgeInsets.only(bottom: 50),
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    "dr.ali@pooleye.com",
                    style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
        Container(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 20.5),
          height: MediaQuery.of(context).size.height / 2.25,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              textfield(hintText: "Password:******", type: "Password"),
              textfield(hintText: "Logout", type: "Logout"),
            ],
          ),
        ),
      ]),
    );
  }
}
