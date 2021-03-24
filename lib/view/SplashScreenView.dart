import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        //title: Image.asset('images/Dcode_home.jpg', fit: BoxFit.cover),
        title: new Text("Waiting"),
        backgroundColor: c1,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
