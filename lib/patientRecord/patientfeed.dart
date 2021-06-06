import 'package:cardio_ai_admin/model/patient_data_model.dart';
import 'package:cardio_ai_admin/patientRecord/patient_list.dart';
import 'package:cardio_ai_admin/shared/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

final Query recordPrediction = FirebaseFirestore.instance
    .collection('Patient Record')
    .orderBy('prediction', descending: true);

List<PatientDataModel> patientDataSnapShot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    return PatientDataModel(
      doc.get('name'),
      doc.get('op number'),
      doc.get('prediction'),
      doc.get('entry'),
    );
  }).toList();
}

Stream<List<PatientDataModel>> get getpatientFeedPrediction {
  return recordPrediction.snapshots().map(patientDataSnapShot);
}


class _PatientListState extends State<PatientList> {
  bool risk = true;
  bool name = false;
  bool op = false;
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Sort ",
              style: whitePopSmall,
            ),
            ActionChip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: Text('R'),
                ),
                label: Text('Risk', style: whitePopSmall,),
                backgroundColor: (risk) ? Colors.blueAccent : darkCard,
                onPressed: () {
                  setState(() {
                    risk=true;
                    name=false;
                    op=false;
                  });
                  print("Chip 1 - Abhi");
                }),
            ActionChip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: Icon(Icons.arrow_upward),
                ),
                label: Text(
                  'Patient Name',
                  style: whitePopSmall,
                ),
                backgroundColor: (name) ? Colors.blueAccent : darkCard,
                onPressed: () {
                  setState(() {
                    risk=false;
                    name=true;
                    op=false;
                  });
                  print("Chip 2 - Computer");
                }),
            ActionChip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: Text('O'),
                ),
                label: Text('OP number', style: whitePopSmall,),
                backgroundColor: (op) ? Colors.blueAccent : darkCard,
                onPressed: () {
                  setState(() {
                    risk=false;
                    name=false;
                    op=true;
                  });
                }),
          ],
        ),
        SizedBox(height: 10,),
        SingleChildScrollView(
          child: StreamProvider<List<PatientDataModel>>.value(
            value:getpatientFeedPrediction,
            initialData: [],
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Column(
                children: [
                  PatientDataList(sortCode: (risk)?0:(name)?1:2,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
