import 'package:cardio_ai_admin/global%20messaging/global_messaging_tile.dart';
import 'package:cardio_ai_admin/model/globalMessagingModel.dart';
import 'package:flutter/material.dart';

class GlobalMessagingList extends StatefulWidget {
  final List<GlobalMessagingModel> messages;
  final String patientUid;
  GlobalMessagingList({Key? key, required this.messages, required this.patientUid}) : super(key: key);


  @override
  _GlobalMessagingListState createState() => _GlobalMessagingListState();
}

class _GlobalMessagingListState extends State<GlobalMessagingList> {
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: widget.messages.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return GlobalMessagingTile(patientUid: widget.patientUid,input:widget.messages[index],deleteItem: (){},);
        }
    );
  }
}