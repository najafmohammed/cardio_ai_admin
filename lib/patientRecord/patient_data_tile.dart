import 'package:cardio_ai_admin/model/patient_data_model.dart';
import 'package:cardio_ai_admin/shared/colors.dart';
import 'package:flutter/material.dart';

class PatientTile extends StatefulWidget {
final PatientDataModel model;

  const PatientTile(this.model);
  @override
  _PatientTileState createState() => _PatientTileState();
}

class _PatientTileState extends State<PatientTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
      child: Card(
        color: darkCard,
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Patient Name "+widget.model.name,style: whitePopLarge(Colors.white),),
          ),
          leading: CircleAvatar(child: Icon(Icons.person),),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("OP Number "+widget.model.opNumber,style: whitePopLarge(Colors.white),),
          ),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Risk "+widget.model.prediction.toString(),style: whitePopLarge(Colors.white),),
          ),
        ),
      ),
    );
  }
}
