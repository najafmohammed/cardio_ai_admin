import 'package:cardio_ai_admin/model/patient_data_model.dart';
import 'package:cardio_ai_admin/patientRecord/patient_list.dart';
import 'package:cardio_ai_admin/shared/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
      doc.id,
      doc.get('entry'),
    );
  }).toList();
}

Stream<List<PatientDataModel>> get getpatientFeedPrediction {
  return recordPrediction.snapshots().map(patientDataSnapShot);
}

class _PatientListState extends State<PatientList> {
  bool risk = true;
  bool riskAsc = false;
  bool name = false;
  bool nameAsc = true;
  bool op = false;
  bool opAsc = true;
  String query="";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Sort ",
              style: whitePopSmall,
            ),
            ActionChip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: (riskAsc)
                      ? Icon(Icons.arrow_upward)
                      : Icon(Icons.arrow_downward),
                ),
                label: Text(
                  'Risk',
                  style: whitePopSmall,
                ),
                backgroundColor: (risk) ? Colors.blueAccent : darkCard,
                onPressed: () {
                  setState(() {
                    if (risk) riskAsc = !riskAsc;
                    risk = true;
                    name = false;
                    op = false;
                  });
                }),
            ActionChip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: (nameAsc)
                      ? Icon(Icons.arrow_upward)
                      : Icon(Icons.arrow_downward),
                ),
                label: Text(
                  'Patient Name',
                  style: whitePopSmall,
                ),
                backgroundColor: (name) ? Colors.blueAccent : darkCard,
                onPressed: () {
                  setState(() {
                    if (name) nameAsc = !nameAsc;
                    risk = false;
                    name = true;
                    op = false;
                  });
                }),
            ActionChip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: (opAsc)
                      ? Icon(Icons.arrow_upward)
                      : Icon(Icons.arrow_downward),
                ),
                label: Text(
                  'OP number',
                  style: whitePopSmall,
                ),
                backgroundColor: (op) ? Colors.blueAccent : darkCard,
                onPressed: () {
                  setState(() {
                    if (op) opAsc = !opAsc;
                    risk = false;
                    name = false;
                    op = true;
                  });
                }),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: TextField(
            cursorColor: Colors.white,
            onChanged: (val) {
              setState(() {
                query=val;
              });
              print(val);
            },style: whitePopLarge(Colors.white),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              labelText: 'Search',
              labelStyle: whitePopLarge(Colors.white),
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          children: [
            StreamProvider<List<PatientDataModel>>.value(
              value: getpatientFeedPrediction,
              initialData: [
                PatientDataModel("null", 1, 2,"VznTJKBUPsfS2G3gBVIfskmcea02",[
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0
                ])
              ],
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Column(
                  children: [
                    PatientDataList(
                      query: query,
                      sortCode: (risk && riskAsc)
                          ? 00
                          : (risk && !riskAsc)
                              ? 01
                              : (name && nameAsc)
                                  ? 10
                                  : (name && !nameAsc)
                                      ? 11
                                      : (op && opAsc)
                                          ? 20
                                          : 21,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
