import 'package:flutter/material.dart';
import 'package:pooleye/model/lifeguardReport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class LifeguardReportController {
  Stream<List<LifeguardReport>> lifeguardreport;
  LifeguardReportController() {
    /*this.addLifeguardReport(
        id: 'VAeMh7ULzxDrftSBIl7q', comment: 'Nothing serious', type: 'cpr');*/
  }
  Future<void> fetchLifeguardReports() async {
    await Firebase.initializeApp();
    lifeguardreport = Firestore.instance
        .collection("lifeguardreports")
        .snapshots()
        .map((event) => event.documents
            .map((DocumentSnapshot documentSnapshot) => LifeguardReport(
                id: documentSnapshot.documentID,
                text: documentSnapshot.data()['text']))
            .toList());
  }

  void addLifeguardReport({id, comment, type}) {
    var now = new DateTime.now();
    Firestore.instance
        .collection("lifeguardreports")
        .document(id)
        .setData({'comment': comment, 'type': type, 'date': now});
  }
}
