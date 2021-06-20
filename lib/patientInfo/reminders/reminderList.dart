
import 'package:cardio_ai_admin/model/reminderModel.dart';
import 'package:cardio_ai_admin/patientInfo/reminders/reminder_tile.dart';
import 'package:flutter/material.dart';

class ReminderList extends StatefulWidget {
  final List<reminderModel> reminders;
  final String patientUid;
  const ReminderList({Key? key, required this.reminders, required this.patientUid}) : super(key: key);

  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: widget.reminders.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return ReminderTile(widget.reminders[index],(){
            widget.reminders.removeAt(index);
          },widget.patientUid);
        }
    );
  }
}
