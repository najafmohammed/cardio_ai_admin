import 'package:cardio_ai_admin/model/doctorModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'doctorTile.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  //docs
  List<DoctorModel> docs=[
    DoctorModel(rating: 4, name: "doc 1", specialization: "spec 1"),
    DoctorModel(rating: 3, name: "doc 2", specialization: "spec 2"),
    DoctorModel(rating: 5, name: "doc 3", specialization: "spec 3"),
    DoctorModel(rating: 3, name: "doc 4", specialization: "spec 4"),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ListView.builder(
        itemCount: docs.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return DoctorTile(docs: docs[index],);
        },
      ),
    );
  }
}
