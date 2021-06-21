import 'package:cardio_ai_admin/global%20messaging/global_messaging_tile.dart';
import 'package:cardio_ai_admin/model/globalMessagingModel.dart';
import 'package:flutter/material.dart';

class GlobalMessagingList extends StatefulWidget {
  final List<GlobalMessagingModel> messages;
  final String patientUid;
  final bool news;
  final bool tips;
  final bool test;
  final VoidCallback updateCount;
  GlobalMessagingList(
      {Key? key, required this.messages, required this.patientUid, required this.news, required this.tips, required this.test, required this.updateCount})
      : super(key: key);

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
          return GlobalMessagingTile(
            news: widget.news,
            tips: widget.tips,
            test: widget.test,
            patientUid: widget.patientUid,
            input: widget.messages[index],
            deleteItem: () {
              widget.updateCount();
              widget.messages.removeAt(index);
            },
          );
        });
  }
}
