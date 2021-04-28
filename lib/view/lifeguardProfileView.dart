import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pooleye/database/firebase.dart';
/*import 'package:gallery_saver/gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';*/
import "package:provider/provider.dart";
import 'package:pooleye/controller/lifeguardController.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pooleye/controller/medicController.dart';
import 'package:pooleye/controller/organizationManagerController.dart';

class lifeguardProfile extends StatefulWidget {
  static Pattern pattern;
  final String type;
  _lifeguardProfile createState() => _lifeguardProfile(type);
  lifeguardProfile(this.type);
}

class _lifeguardProfile extends State<lifeguardProfile> {
  final String accType;
  _lifeguardProfile(this.accType);
  GetFirebase fb = GetFirebase();
  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  TextFormField test;
  static final validCharacters = RegExp(r"^[a-zA-Z]+$");
  final _formKey = GlobalKey<FormState>();
  TextEditingController _customController;
  //Userprovider userOn = new Userprovider();
  var userList;
  bool prog = true;
  bool err = false;
  var update;
  String _imageUrl;
  File uImage;
  //ScreenshotController screenshotController = ScreenshotController();
  File _imageFile;
  bool _loading = false;
  bool save_done = true;
  bool save_done2 = false;
  var user_id;
  int userIndex;
  var ref;
  List userNames = [];

  @override
  void initState() {
    if (accType == 'lifeguard') {
      Provider.of<Lifeguardprovider>(this.context, listen: false)
          .fetchdata()
          .then((value) {
        prog = false;
      });
    } else if (accType == 'medic') {
      Provider.of<Medicprovider>(this.context, listen: false)
          .fetchdata()
          .then((value) {
        prog = false;
      });
    } else if (accType == 'org') {
      Provider.of<OrganizationMangerprovider>(this.context, listen: false)
          .fetchdata()
          .then((value) {
        prog = false;
      });
    }
    //update = Provider.of<Lifeguardprovider>(this.context, listen: false);
    var uPic;
    uPic = GetFirebase().getUserID;
    try {
      ref = GetFirebase().fbStorage.child('user' + uPic + '.png');
      ref.getDownloadURL().then((loc) {
        setState(() {
          _imageUrl = loc;
        });
      });
    } catch (error) {
      _imageUrl = null;
    }
    super.initState();
  }

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 30),
          child: Text(type,
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 2,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              )),
        ),
        Material(
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
                      icon: type == "Logout"
                          ? Icon(Icons.logout)
                          : type == 'Email'
                              ? Container()
                              : Icon(Icons.edit),
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
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (prog == false) {
      if (userList.isEmpty) {
        err = true;
      }
    }
    if (accType == "lifeguard") {
      userList =
          Provider.of<Lifeguardprovider>(this.context, listen: true).lifeguard;
      user_id = GetFirebase().getUserID;
      userIndex = userList.indexWhere((element) => element.id == user_id);
    } else if (accType == "medic") {
      userList = Provider.of<Medicprovider>(this.context, listen: true).medic;
      user_id = GetFirebase().getUserID;
      userIndex = userList.indexWhere((element) => element.id == user_id);
    } else if (accType == "org") {
      userList =
          Provider.of<OrganizationMangerprovider>(this.context, listen: true)
              .orgManagers;
      user_id = GetFirebase().getUserID;
      userIndex = userList.indexWhere((element) => element.id == user_id);
    }
    return err
        ? WillPopScope(
            onWillPop: () async {
              return Navigator.canPop(context); // avoid app from exiting
            },
            child: Scaffold(
              body: new AlertDialog(
                title: new Text('Error'),
                content: new Text('Error while fetching data!'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () =>
                        /*Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage('test')),
                      (Route<dynamic> route) => false,
                    ),*/
                        Navigator.of(context).pop(true),
                    child: new Text('Exit'),
                  ),
                ],
              ),
            ),
          )
        : WillPopScope(
            onWillPop: () async {
              return Navigator.canPop(context); // avoid app from exiting
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: new AppBar(
                title: Text("Profile"),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                backgroundColor: const Color.fromRGBO(110, 204, 234, 1.0),
              ),
              body: prog
                  ? Center(child: CircularProgressIndicator())
                  : ListView(children: [
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
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.width / 2,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 5),
                                          shape: BoxShape.circle,
                                          color: Colors.blueAccent
                                              .withOpacity(0.2),
                                          image: DecorationImage(
                                              image: _imageUrl != null
                                                  ? uImage == null
                                                      ? NetworkImage(_imageUrl)
                                                      : FileImage(uImage)
                                                  : AssetImage(
                                                      "images/lifeguard.jpg")))),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 140,
                                        left:
                                            MediaQuery.of(context).size.width /
                                                2.2),
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
                                  "Profile",
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
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 20.5),
                        height: MediaQuery.of(context).size.height / 2.25,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Text('Name'),
                            textfield(
                                hintText: userList[userIndex].role ==
                                        'organisationManager'
                                    ? userList[userIndex].orgName
                                    : userList[userIndex].username,
                                type: userList[userIndex].role ==
                                        'organisationManager'
                                    ? "Organization Name"
                                    : "Name"),
                            textfield(
                                hintText: userList[userIndex].email,
                                type: "Email"),
                            textfield(hintText: "Logout", type: "Logout"),
                          ],
                        ),
                      ),
                    ]),
            ));
  }
}
