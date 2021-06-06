import 'package:cardio_ai_admin/model/doctorModel.dart';
import 'package:cardio_ai_admin/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorTile extends StatefulWidget {

  final DoctorModel docs;

  const DoctorTile({Key? key, required this.docs}) : super(key: key);

  @override
  _DoctorTileState createState() => _DoctorTileState();
}

class _DoctorTileState extends State<DoctorTile> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: darkCard,
          child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.person),),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Doctor Name: "+widget.docs.name.toString(),
                style: whitePopLarge(Colors.white),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Specialization: "+widget.docs.specialization.toString(),
                style: whitePopLarge(Colors.white),
              ),
            ),
            trailing: SizedBox(
              width: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.docs.rating.toString(),
                    style: whitePopLarge(Colors.white),
                  ),
                  Icon(Icons.star,color: Colors.red,)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}