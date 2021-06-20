import 'package:cardio_ai_admin/model/globalMessagingModel.dart';
import 'package:flutter/material.dart';

class GlobalMessagingTile extends StatefulWidget {
  final VoidCallback deleteItem;
  final String patientUid;
  final GlobalMessagingModel input;
  GlobalMessagingTile( {required this.deleteItem, required this.patientUid,required this.input});

  @override
  _GlobalMessagingTileState createState() => _GlobalMessagingTileState();
}

class _GlobalMessagingTileState extends State<GlobalMessagingTile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}