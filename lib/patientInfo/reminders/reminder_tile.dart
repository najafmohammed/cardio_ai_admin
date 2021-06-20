import 'package:cardio_ai_admin/model/reminderModel.dart';
import 'package:cardio_ai_admin/shared/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReminderTile extends StatefulWidget {
  ReminderTile(this.input, this.deleteItem, this.patientUid);
  final VoidCallback deleteItem;
  final String patientUid;
  final reminderModel input;
  @override
  _ReminderTileState createState() => _ReminderTileState();
}

CollectionReference recordPredictionReminder =
FirebaseFirestore.instance.collection('Patient Record');
class _ReminderTileState extends State<ReminderTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.deepPurple.shade400,
        child: ListTile(
          title: Text(
            widget.input.text,
            style: whitePopLarge(Colors.white),
          ),
          leading: Icon(Icons.circle),
          trailing: InkWell(
              onTap: ()async{
                await recordPredictionReminder
                    .doc(widget.patientUid)
                    .collection("Reminders").doc(widget.input.uid).delete().then((value) => widget.deleteItem());
              },
              child: Icon(Icons.delete,color: Colors.red,)),
        ),
      ),
    );
  }
}
