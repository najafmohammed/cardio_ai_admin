import 'package:cardio_ai_admin/model/patient_data_model.dart';
import 'package:cardio_ai_admin/patientRecord/patient_data_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientDataList extends StatefulWidget {
  const PatientDataList({Key? key, required this.sortCode}) : super(key: key);
  final int sortCode;
  @override
  _PatientDataListState createState() => _PatientDataListState();
}

class _PatientDataListState extends State<PatientDataList> {
  @override
  Widget build(BuildContext context) {
    var PatientRecord = Provider.of<List<PatientDataModel>>(context);
    switch (widget.sortCode) {
      case 00:
        {
          PatientRecord.sort((a, b) => a.prediction.compareTo(b.prediction));
          break;
        }
      case 01:
        {
          PatientRecord.sort((b, a) => a.prediction.compareTo(b.prediction));
          break;
        }
      case 10:
        {
          PatientRecord.sort((a, b) => a.name.compareTo(b.name));
          break;
        }
      case 11:
        {
          PatientRecord.sort((b, a) => a.name.compareTo(b.name));
          break;
        }
      case 20:
        {
          PatientRecord.sort((a, b) => a.opNumber.compareTo(b.opNumber));
          break;
        }
      case 21:
        {
          PatientRecord.sort((b, a) => a.opNumber.compareTo(b.opNumber));
          break;
        }
      default:
        {
          PatientRecord.sort((a, b) => a.prediction.compareTo(b.prediction));
          break;
        }
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.24,
      child: Scrollbar(
        isAlwaysShown: true,
        child: Expanded(
          child: ListView.builder(
            itemCount: PatientRecord.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return PatientTile(PatientRecord[index], index);
            },
          ),
        ),
      ),
    );
  }
}
