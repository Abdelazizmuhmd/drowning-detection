import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pooleye/model/OrganisationManager.dart';
import 'package:pooleye/database/firebase.dart';

class OrganizationMangerprovider with ChangeNotifier {
  List<OrganisationManager> orgManagers = [];
  Future<void> fetchdata() async {
    await Firebase.initializeApp();
    try {
      var snaps = FirebaseFirestore.instance.collection('users');
      snaps.snapshots().listen((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((document) async {
          if (document.data()['role'] == "organisationManager") {
            orgManagers.add(OrganisationManager(
              id: await document.id,
              orgCode: await document.data()['orgCode'],
              role: await document.data()['role'],
              email: await document.data()['email'],
              orgName: await document.data()['orgainsationName'],
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
    final userIndex = orgManagers.indexWhere((element) => element.id == id);
    var snaps = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(val)
        .catchError((e) {});

    var nMap = Map<String, dynamic>.from(val);
    print(nMap);
    for (final key in nMap.keys) {
      if (key == 'orgainsationName') {
        orgManagers[userIndex].orgName = nMap[key];
        var mysnaps = FirebaseFirestore.instance
            .collection('organisations')
            .document(orgManagers[userIndex].orgCode)
            .updateData({'orgainsationName': orgManagers[userIndex].orgName});
      }
    }
    notifyListeners();
  }
}
