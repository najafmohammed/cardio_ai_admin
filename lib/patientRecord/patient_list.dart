
import 'package:cardio_ai_admin/model/patient_data_model.dart';
import 'package:cardio_ai_admin/patientRecord/patient_data_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientDataList extends StatefulWidget {

  @override
  _PatientDataListState createState() => _PatientDataListState();
}
class _PatientDataListState extends State<PatientDataList> {
  @override
  Widget build(BuildContext context) {
    final PatientRecord = Provider.of<List<PatientDataModel>>(context);
    return ListView.builder(
      itemCount: PatientRecord.length,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return PatientTile(PatientRecord[index],index);
      },
    );
  }
}