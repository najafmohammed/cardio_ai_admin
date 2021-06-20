import 'package:cardio_ai_admin/model/globalMessagingModel.dart';
import 'package:cardio_ai_admin/shared/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GlobalMessagingTile extends StatefulWidget {
  final VoidCallback deleteItem;
  final String patientUid;
  final GlobalMessagingModel input;
  GlobalMessagingTile( {required this.deleteItem, required this.patientUid,required this.input});

  @override
  _GlobalMessagingTileState createState() => _GlobalMessagingTileState();
}

CollectionReference globalMessageCollection =
FirebaseFirestore.instance.collection('Global');
class _GlobalMessagingTileState extends State<GlobalMessagingTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.deepPurple.shade400,
        child: ListTile(
          title: Text(
            widget.input.tittle,
            style: whitePopLarge(Colors.white),
          ),
          subtitle: Text(
            widget.input.text,
            style: whitePopSmall,
          ),
          leading: Icon(Icons.circle),
          trailing: InkWell(
              onTap: ()async{
                await globalMessageCollection
                    .doc("Messaging")
                    .collection("Test").doc(widget.input.uid).delete();
                widget.deleteItem();
              },
              child: Icon(Icons.delete,color: Colors.red,)),
        ),
      ),
    );
  }
}