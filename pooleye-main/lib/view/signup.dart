import 'package:flutter/material.dart';
import 'package:pooleye/view/login.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0); // fully transparent white (invisible)
  final _formKey = GlobalKey<FormState>();
  static final validCharacters = RegExp(r"^[a-zA-Z]+$");
  bool visible_manager = false;
  bool visible_others = false;
  List<String> _locations = [
    'Organisation Manager',
    'Lifeguard',
    'Medical Team member'
  ]; // Option 2
  String _selectedLocation; // Option 2
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        title: Row(
          children: [
            Text(
              "Pooleye ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Image.asset('images/swimming-pool.png',
                fit: BoxFit.cover, width: 45),
          ],
        ),
        backgroundColor: c1,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(20.0)),
            new Center(
              child: new Text(
                "Sign Up",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.blue),
              ),
            ),
            Container(
              padding: EdgeInsets.all(50.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.blueGrey,
                          size: 30.0,
                        ),
                        new Padding(padding: new EdgeInsets.all(10.0)),
                        DropdownButton(
                          hint: Text(
                              'Please choose Your Role'), // Not necessary for Option 1
                          value: _selectedLocation,
                          onChanged: (newValue) {
                            if (newValue == 'Organisation Manager') {
                              setState(() {
                                visible_others = false;
                                visible_manager = true;
                              });
                            }
                            if (newValue == 'Lifeguard') {
                              setState(() {
                                visible_others = true;
                                visible_manager = false;
                              });
                            }
                            if (newValue == 'Medical Team member') {
                              setState(() {
                                visible_others = true;
                                visible_manager = false;
                              });
                            }
                            setState(() {
                              _selectedLocation = newValue;
                            });
                          },
                          items: _locations.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    new Padding(padding: new EdgeInsets.all(20.0)),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Username';
                        }
                        if (value.length > 25) {
                          return 'Username is too long';
                        }
                        if (value.length < 11) {
                          return 'Username is too short';
                        }
                        if (!value.contains('@pooleye.com')) {
                          return 'username should end with @pooleye.com';
                        }
                        return null;
                      },
                      decoration: new InputDecoration(
                          hintText: 'Username@pooleye.com',
                          border: const OutlineInputBorder(),
                          icon: new Icon(
                            Icons.account_circle,
                            color: Colors.blueGrey,
                            size: 30.0,
                          )),
                    ),
                    new Padding(padding: new EdgeInsets.all(20.0)),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        if (value.length > 25) {
                          return 'Password is too long';
                        }
                        if (value.length < 5) {
                          return 'Password is too short';
                        }
                        return null;
                      },
                      decoration: new InputDecoration(
                          hintText: 'Password',
                          border: const OutlineInputBorder(),
                          icon: new Icon(
                            Icons.lock,
                            color: Colors.blueGrey,
                            size: 30.0,
                          )),
                      obscureText: true,
                    ),
                    new Padding(padding: new EdgeInsets.all(20.0)),
                    Visibility(
                      visible: visible_manager,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter The Organisation Name';
                          }
                          if (value.length < 3) {
                            return 'Organisation Name is too short';
                          }

                          if (value.length > 18) {
                            return 'Organisation Name is too long';
                          }

                          if (!validCharacters.hasMatch(value)) {
                            return 'Organisation Name should be alphabets only';
                          }
                          return null;
                        },
                        decoration: new InputDecoration(
                            hintText: 'Organisation Name',
                            border: const OutlineInputBorder(),
                            icon: new Icon(
                              Icons.house_outlined,
                              color: Colors.blueGrey,
                              size: 30.0,
                            )),
                      ),
                    ),
                    Visibility(
                      visible: visible_others,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter The Organisation ID';
                          }
                          if (value.length < 3) {
                            return 'Organisation ID is too short';
                          }

                          if (value.length > 18) {
                            return 'Organisation ID is too long';
                          }
                          return null;
                        },
                        decoration: new InputDecoration(
                            hintText: 'Organisation ID',
                            border: const OutlineInputBorder(),
                            icon: new Icon(
                              Icons.ad_units,
                              color: Colors.blueGrey,
                              size: 30.0,
                            )),
                      ),
                    ),
                    new Padding(padding: new EdgeInsets.all(20.0)),
                    Visibility(
                      visible: visible_manager,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter The Number of Swimming Pools';
                          }
                          if (value.length < 1) {
                            return 'The Number of Swimming Pools is too short';
                          }

                          if (value.length > 5) {
                            return 'The Number of Swimming Pools is too long';
                          }
                          return null;
                        },
                        decoration: new InputDecoration(
                            hintText: 'Number of Swimming Pools',
                            border: const OutlineInputBorder(),
                            icon: new Icon(
                              Icons.pool,
                              color: Colors.blueGrey,
                              size: 30.0,
                            )),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: SizedBox(
                          width: 120,
                          child: RaisedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, Go to Home screen.
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              }
                            },
                            child: Text('Sign Up'),
                            color: Colors.cyan,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
