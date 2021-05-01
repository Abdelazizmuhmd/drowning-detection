import 'package:pooleye/model/lifeguardReport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class LifeguardReportController {
  Stream<List<LifeguardReport>> lifeguardreport;
  LifeguardReportController() {
    /*this.addLifeguardReport(
        id: 'VAeMh7ULzxDrftSBIl7q', comment: 'Nothing serious', type: 'cpr');*/
  }
  Future<void> fetchLifeguardReports() async {
    await Firebase.initializeApp();
    lifeguardreport = FirebaseFirestore.instance
        .collection("lifeguardreports")
        .snapshots()
        .map((event) => event.docs
            .map((DocumentSnapshot documentSnapshot) => LifeguardReport(
                id: documentSnapshot.id,
                comment: documentSnapshot.data()['comment'],
                orgId: documentSnapshot.data()['orgID'],
                type: documentSnapshot.data()['type'],
                date: documentSnapshot.data()['date'],
                sent: documentSnapshot.data()['sent']))
            .toList());
  }

  void addLifeguardReport({id, comment, type, orgId}) {
    var now = new DateTime.now();
    FirebaseFirestore.instance.collection("lifeguardreports").doc(id).set({
      'comment': comment,
      'type': type,
      'date': now,
      'orgID': orgId,
      'sent': false,
      'sentTO': "medic"
    });
  }

  void updateSent(id) {
    FirebaseFirestore.instance
        .collection('lifeguardreports')
        .doc(id)
        .update({'sent': true}).catchError((e) {});
  }

  void updatesubscriber(id, subscriber) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'subscriber': subscriber}).catchError((e) {});
  }

  // void getsubscriber(id) {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(id)
  //       .get()
  //       .then((value) => value['subscriber']);
  // }
}
