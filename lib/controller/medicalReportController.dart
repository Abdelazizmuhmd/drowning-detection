import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pooleye/model/medicReport.dart';

class MedicReportController {
  MedicReportController() {}
  Stream<List<MedicReport>> medicreport;

  Future<void> fetchMedicReports() async {
    await Firebase.initializeApp();
    medicreport = FirebaseFirestore.instance
        .collection("medicreports")
        .snapshots()
        .map((event) => event.docs
            .map((DocumentSnapshot documentSnapshot) => MedicReport(
                  id: documentSnapshot.id,
                  comment: documentSnapshot.data()['comment'],
                  orgId: documentSnapshot.data()['orgID'],
                  date: documentSnapshot.data()['date'],
                ))
            .toList());
  }

  void addMedicReport({id, comment, orgId}) {
    var now = new DateTime.now();
    FirebaseFirestore.instance.collection("medicreports").doc(id).set({
      'comment': comment,
      'date': now,
      'orgID': orgId,
    });
  }
}
