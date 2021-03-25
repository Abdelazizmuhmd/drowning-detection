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
                comment: documentSnapshot.data()['comment'],
                orgId: documentSnapshot.data()['orgID'],
                type: documentSnapshot.data()['type'],
                date: documentSnapshot.data()['date'],
                sent: documentSnapshot.data()['sent']))
            .toList());
  }

  void addLifeguardReport({id, comment, type, orgId}) {
    var now = new DateTime.now();
    Firestore.instance.collection("lifeguardreports").document(id).setData({
      'comment': comment,
      'type': type,
      'date': now,
      'orgID': orgId,
      'sent': false
    });
  }

  void updateSent(id) {
    FirebaseFirestore.instance
        .collection('lifeguardreports')
        .document(id)
        .updateData({'sent': true}).catchError((e) {});
  }
}
