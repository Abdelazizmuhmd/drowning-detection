import 'package:clipboard/clipboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pooleye/controller/organisationManagerController.dart';
import 'package:pooleye/database/firebase.dart';
import 'package:pooleye/model/OrganisationManager.dart';
import 'package:provider/provider.dart';

class GeneratedCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GeneratedCodeState();
  }
}

class GeneratedCodeState extends State<GeneratedCode> {
  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  static GetFirebase orgCode = GetFirebase();
  TextEditingController controller = TextEditingController();
  List<OrganisationManager> orgmanagers;
  bool prog = true;
  int userIndex;
  @override
  void initState() {
    Provider.of<OrganisationMangerprovider>(this.context, listen: false)
        .fetchdata()
        .then((value) {
      prog = false;
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    if (prog == false) {
      userIndex =
          orgmanagers.indexWhere((element) => element.id == orgCode.getUserID);
    }
    orgmanagers =
        Provider.of<OrganisationMangerprovider>(this.context, listen: true)
            .orgManagers;
    return Scaffold(
      appBar: AppBar(
        title: Text("Generated Code Page"),
        backgroundColor: c1,
      ),
      backgroundColor: Colors.white,
      body: prog
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                new Padding(padding: new EdgeInsets.all(20.0)),
                new Center(
                  child: new Text(
                    "Generated Code",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.blue),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: controller
                              ..text = (orgmanagers[userIndex].getorgCode),
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: "The Code",
                            ),
                          )),
                          IconButton(
                            icon: Icon(Icons.content_copy),
                            onPressed: () async {
                              await FlutterClipboard.copy(controller.text);

                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('✓   Copied to Clipboard')),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
    );
    // return Container();
  }
}
