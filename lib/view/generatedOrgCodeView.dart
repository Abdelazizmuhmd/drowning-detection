import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:pooleye/database/firebase.dart';

class GeneratedCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GeneratedCodeState();
  }
}

class GeneratedCodeState extends State<GeneratedCode> {
  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  TextEditingController controller =
      TextEditingController(text: 'Khalooood3amlEh');
  String paste = '';
  String code = "KhaledBashaMasr";
  Firebase currentUserId = Firebase();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Generated Code Page"),
          backgroundColor: c1,
        ),
        backgroundColor: Colors.white,
        body: buildCopy(),
      );

  Widget buildCopy() => Builder(
      builder: (context) => ListView(
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
                          controller: controller,
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
          ));
}
