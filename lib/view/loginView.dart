import 'package:flutter/material.dart';
import 'package:pooleye/services/signupAuth.dart';
import 'package:pooleye/view/orgainsationDailyreportView.dart';
import 'package:pooleye/view/signupView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final void Function(String email, String password, BuildContext ctx) submitFn;
  final bool _isLoading;
  Login(this.submitFn, this._isLoading);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0); // fully transparent white (invisible)
  final _formKey = GlobalKey<FormState>();
  String _savedDataUsername = "";
  String _savedDataPassword = "";
  bool _isHidden = true;
  String userNameObsecure;

  var _usernameField = new TextEditingController();
  var _passwordField = new TextEditingController();

  @override
  void initState() {
    _loadSavedData();
    super.initState();
  }

  _loadSavedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userNameObsecure = sharedPreferences.getString('username');
    setState(() {
      if (sharedPreferences.getString('username') != null &&
          sharedPreferences.getString('username').isNotEmpty) {
        _savedDataUsername = sharedPreferences.getString('username');
      }
      if (sharedPreferences.getString('password') != null &&
          sharedPreferences.getString('password').isNotEmpty) {
        _savedDataPassword = sharedPreferences.getString('password');
      } else {
        _savedDataPassword = '';
      }
    });
  }

  _saveData(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('username', username);
    sharedPreferences.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    _usernameField.text = _savedDataUsername;
    _passwordField.text = _savedDataPassword;
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: Image.asset(
                'images/swimming-pool.png',
                fit: BoxFit.cover,
                width: 100,
              ),
            ),
            Container(
              padding: EdgeInsets.all(50.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _usernameField,
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
                      hintText: 'Username@pooleye.com',
                      icon: new Icon(Icons.person),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(20.0)),
                  TextFormField(
                    controller: _passwordField,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Your Password';
                      }
                      return null;
                    },
                    decoration: new InputDecoration(
                      hintText: 'Password',
                      icon: new Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      suffixIcon: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(
                          _isHidden ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                    obscureText: _isHidden,
                  ),
                  widget._isLoading
                      ? CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: RaisedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_formKey.currentState.validate()) {
                                //If the form is valid, Go to Home screen.

                                widget.submitFn(
                                  _usernameField.text.trim(),
                                  _passwordField.text.trim(),
                                  context,
                                );
                                _saveData(
                                    _usernameField.text, _passwordField.text);
                                _loadSavedData();
                              }
                            },
                            child: Text('Login'),
                            color: Colors.cyan,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                        ),
                  TextButton(
                      child: Text(
                        "haven't an account ? Sign Up Now",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AuthForm()),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
      _savedDataUsername = _usernameField.text;
      _savedDataPassword = _passwordField.text;
    });
  }
}
