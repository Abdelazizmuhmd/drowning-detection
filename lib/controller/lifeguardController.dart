import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pooleye/model/lifeguard.dart';

class Lifeguardprovider with ChangeNotifier {
  List<Lifeguard> lifeguard = [];
  Future<void> fetchdata() async {
    await Firebase.initializeApp();
    try {
      var snaps = FirebaseFirestore.instance.collection('users');
      snaps.snapshots().listen((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((document) async {
          if (document.data()['role'] == "lifeguard" &&
              document.data()['deleted'] == 0) {
            lifeguard.add(Lifeguard(
              id: await document.id,
              orgCode: await document.data()['orgCode'],
              role: await document.data()['role'],
              email: await document.data()['email'],
              username: await document.data()['username'],
            ));
          }
        });
        snaps.get().then((value) {
          notifyListeners();
        });
      });
    } catch (error) {
      notifyListeners();
    }
  }

  Future<void> updateData(String id, val) async {
    final userIndex = lifeguard.indexWhere((element) => element.id == id);
    var snaps = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(val)
        .catchError((e) {});

    var nMap = Map<String, dynamic>.from(val);
    print(nMap);
    for (final key in nMap.keys) {
      if (key == 'deleted') lifeguard[userIndex].deleted = nMap[key];
    }
    notifyListeners();
  }
}
