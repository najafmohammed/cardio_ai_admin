import 'package:cardio_ai_admin/model/patient_data_model.dart';
import 'package:cardio_ai_admin/patientRecord/patient_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}
final Query record = FirebaseFirestore.instance
    .collection('Patient Record')
    .orderBy('prediction', descending: true);

List<PatientDataModel> patientDataSnapShot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    return PatientDataModel(
      doc.get('patient name'),
      doc.get('op number'),
      doc.get('prediction'),
      doc.get('entry'),
    );
  }).toList();
}

Stream<List<PatientDataModel>> get getpatientFeed {
  return record.snapshots().map(patientDataSnapShot);
}
class _PatientListState extends State<PatientList> {


  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PatientDataModel>>.value(
      value: getpatientFeed,
      initialData: [],
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        child: Column(
          children: [
            PatientDataList(),
          ],
        ),
      ),
    );
  }
}
