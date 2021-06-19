
import 'package:cardio_ai_admin/model/reminderModel.dart';
import 'package:flutter/material.dart';

class ReminderList extends StatefulWidget {
  final List<reminderModel> reminders;
  const ReminderList({Key? key, required this.reminders}) : super(key: key);

  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  @override
  Widget build(BuildContext context) {
  widget.reminders.forEach((element) {print(element.text);});
    return Text("sdfs");
  }
}
