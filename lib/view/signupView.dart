import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pooleye/view/loginView.dart';

class Signup extends StatefulWidget {
  final void Function(
      String orgainsationName,
      String role,
      String email,
      String password,
      BuildContext ctx,
      String organisationCode,
      String username) submitFn;
  final bool _isLoading;
  Signup(this.submitFn, this._isLoading);
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
  var _email = new TextEditingController();
  var _organisationName = new TextEditingController();
  String role = "organisationManager";
  var _password = new TextEditingController();
  var orgId = new TextEditingController();
FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  var employeesUsername = new TextEditingController();

  static final validCharacters = RegExp(r"^[a-zA-Z]+$");
  bool visible_manager = true;
  bool visible_others = false;
  List<String> _locations = [
    'Organisation Manager',
    'Lifeguard',
    'Medical Team member'
  ]; // Option 2
  String _selectedLocation = "Organisation Manager"; // Option 2
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
                          value: _selectedLocation,
                          onChanged: (newValue) {
                            if (newValue == 'Organisation Manager') {
                              setState(() {
                                visible_others = false;
                                visible_manager = true;
                                role = "organisationManager";
                              });
                            }
                            if (newValue == 'Lifeguard') {
                              setState(() {
                                visible_others = true;
                                visible_manager = false;
                                role = "lifeguard";
                              });
                            }
                            if (newValue == 'Medical Team member') {
                              setState(() {
                                visible_others = true;
                                visible_manager = false;
                                role = "medic";
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
                      controller: _email,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        if (value.length > 25) {
                          return 'Email is too long';
                        }
                        if (value.length < 11) {
                          return 'Email is too short';
                        }
                        if (!value.contains('@')) {
                          return 'Invalid Email';
                        }
                        if (!value.contains('.com')) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      decoration: new InputDecoration(
                          hintText: 'Email',
                          border: const OutlineInputBorder(),
                          icon: new Icon(
                            Icons.email_rounded,
                            color: Colors.blueGrey,
                            size: 30.0,
                          )),
                    ),
                    new Padding(padding: new EdgeInsets.all(20.0)),
                    TextFormField(
                      controller: _password,
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
                        controller: _organisationName,
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
                      child: Column(
                        children: [
                          TextFormField(
                            controller: employeesUsername,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Username';
                              }
                              if (value.length < 3) {
                                return 'Username is too short';
                              }

                              if (value.length > 18) {
                                return 'Username is too long';
                              }

                              if (!validCharacters.hasMatch(value)) {
                                return 'Username should be alphabets only';
                              }
                              return null;
                            },
                            decoration: new InputDecoration(
                                hintText: 'Username',
                                border: const OutlineInputBorder(),
                                icon: new Icon(
                                  Icons.person,
                                  color: Colors.blueGrey,
                                  size: 30.0,
                                )),
                          ),
                          new Padding(padding: new EdgeInsets.all(20.0)),
                          TextFormField(
                            controller: orgId,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter The Organisation ID';
                              }
                              if (value.length < 3) {
                                return 'Organisation ID is too short';
                              }

                              if (value.length > 35) {
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
                        ],
                      ),
                    ),
                    // new Padding(padding: new EdgeInsets.all(20.0)),
                    // Visibility(
                    //   visible: visible_manager,
                    //   child: TextFormField(
                    //     keyboardType: TextInputType.number,
                    //     validator: (value) {
                    //       if (value.isEmpty) {
                    //         return 'Please Enter The Number of Swimming Pools';
                    //       }
                    //       if (value.length < 1) {
                    //         return 'The Number of Swimming Pools is too short';
                    //       }

                    //       if (value.length > 5) {
                    //         return 'The Number of Swimming Pools is too long';
                    //       }
                    //       return null;
                    //     },
                    //     decoration: new InputDecoration(
                    //         hintText: 'Number of Swimming Pools',
                    //         border: const OutlineInputBorder(),
                    //         icon: new Icon(
                    //           Icons.pool,
                    //           color: Colors.blueGrey,
                    //           size: 30.0,
                    //         )),
                    //   ),
                    // ),
                    widget._isLoading
                        ? CircularProgressIndicator()
                        : Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: SizedBox(
                                width: 120,
                                child: RaisedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false
                                    // otherwise.
                                    if (_formKey.currentState.validate()) {
                                      // If the form is valid, Go to Home screen.
                                      widget.submitFn(
                                        _organisationName.text.trim(),
                                        role,
                                        _email.text.trim(),
                                        _password.text.trim(),
                                        context,
                                        orgId.text.trim(),
                                        employeesUsername.text.trim(),
                                        
                                      );
                                          firebaseMessaging.subscribeToTopic(orgId.text.trim()+role);
                                          print(orgId.text.trim()+role);

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
