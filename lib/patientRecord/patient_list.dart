import 'package:cardio_ai_admin/model/patient_data_model.dart';
import 'package:cardio_ai_admin/patientRecord/patient_data_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientDataList extends StatefulWidget {
  const PatientDataList({Key? key, required this.sortCode, required this.query})
      : super(key: key);
  final int sortCode;
  final String query;
  @override
  _PatientDataListState createState() => _PatientDataListState();
}

List<PatientDataModel> mod = [
  PatientDataModel("None found", 0, 0, [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
];

class _PatientDataListState extends State<PatientDataList> {
  @override
  Widget build(BuildContext context) {
    print(widget.sortCode);
    var PatientRecord = Provider.of<List<PatientDataModel>>(context);
    switch (widget.sortCode) {
      case 00:
        {
          PatientRecord.sort((a, b) => a.prediction.compareTo(b.prediction));
          if (widget.query != "") {
            PatientRecord = PatientRecord.where((element) =>
                element.name
                    .toLowerCase()
                    .contains(widget.query.toLowerCase())).toList();
          }
          if (PatientRecord.isEmpty) {
            PatientRecord = mod;
          }
          break;
        }
      case 01:
        {
          PatientRecord.sort((b, a) => a.prediction.compareTo(b.prediction));
          if (widget.query != "") {
            PatientRecord = PatientRecord.where((element) =>
                element.name
                    .toLowerCase()
                    .contains(widget.query.toLowerCase())).toList();
          }
          if (PatientRecord.isEmpty) {
            PatientRecord = mod;
          }
          break;
        }
      case 10:
        {
          PatientRecord.sort((a, b) => a.name.compareTo(b.name));
          if (widget.query != "") {
            PatientRecord = PatientRecord.where((element) =>
                element.name
                    .toLowerCase()
                    .contains(widget.query.toLowerCase())).toList();
          }
          if (PatientRecord.isEmpty) {
            print("yes");
            PatientRecord = mod;
          }
          break;
        }
      case 11:
        {
          PatientRecord.sort((b, a) => a.name.compareTo(b.name));
          if (widget.query != "") {
            PatientRecord = PatientRecord.where((element) =>
                element.name
                    .toLowerCase()
                    .contains(widget.query.toLowerCase())).toList();
          }
          if (PatientRecord.isEmpty) {
            print("yes");
            PatientRecord = mod;
          }
          break;
        }
      case 20:
        {
          PatientRecord.sort((a, b) => a.opNumber.compareTo(b.opNumber));
          if (widget.query != "") {
            PatientRecord = PatientRecord.where((element) =>
                element.opNumber
                    .toString()
                    .toLowerCase()
                    .contains(widget.query.toLowerCase())).toList();
          }
          if (PatientRecord.isEmpty) {
            print("yes");
            PatientRecord = mod;
          }
          break;
        }
      case 21:
        {
          PatientRecord.sort((b, a) => a.opNumber.compareTo(b.opNumber));
          if (widget.query != "") {
            PatientRecord = PatientRecord.where((element) =>
                element.opNumber
                    .toString()
                    .toLowerCase()
                    .contains(widget.query.toLowerCase())).toList();
          }
          if (PatientRecord.isEmpty) {
            PatientRecord = mod;
          }
          break;
        }
      default:
        {
          PatientRecord = mod;
          break;
        }
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.4,
      child: Scrollbar(
        child: ListView.builder(
          itemCount: PatientRecord.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return PatientTile(PatientRecord[index], index);
          },
        ),
      ),
    );
  }
}
