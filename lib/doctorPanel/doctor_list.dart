import 'package:cardio_ai_admin/model/doctorModel.dart';
import 'package:cardio_ai_admin/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'doctorTile.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  _DoctorListState createState() => _DoctorListState();
}
bool rating = true;
bool ratingAsc = false;
bool name = false;
bool nameAsc = true;
bool spec = false;
bool specAsc = true;

class _DoctorListState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {

//docs
    List<DoctorModel> docs = [
      DoctorModel(rating: 4, name: "doc 1", specialization: "spec 1"),
      DoctorModel(rating: 3, name: "doc 2", specialization: "spec 2"),
      DoctorModel(rating: 5, name: "doc 3", specialization: "spec 3"),
      DoctorModel(rating: 3, name: "doc 4", specialization: "spec 4"),
    ];
    if (rating == true && ratingAsc == true) {
      docs.sort((a, b) => a.rating.compareTo(b.rating));
    }
    if (rating == true && ratingAsc == false) {
      docs.sort((b, a) => a.rating.compareTo(b.rating));
    }
    if (name == true && nameAsc == true) {
      docs.sort((a, b) => a.name.compareTo(b.name));
    }
    if (name == true && nameAsc == false) {
      docs.sort((b, a) => a.name.compareTo(b.name));
    }
    if (spec == true && specAsc == true) {
      docs.sort((a, b) => a.specialization.compareTo(b.specialization));
    }
    if (spec == true && specAsc == true) {
      docs.sort((b, a) => a.specialization.compareTo(b.specialization));
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Sort ",
                style: whitePopSmall,
              ),
              ActionChip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: (ratingAsc)
                        ? Icon(Icons.arrow_upward)
                        : Icon(Icons.arrow_downward),
                  ),
                  label: Text(
                    'Rating',
                    style: whitePopSmall,
                  ),
                  backgroundColor: (rating) ? Colors.blueAccent : darkCard,
                  onPressed: () {
                    setState(() {
                      if (rating) ratingAsc = !ratingAsc;
                      rating = true;
                      name = false;
                      spec = false;
                    });
                  }),
              ActionChip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: (nameAsc)
                        ? Icon(Icons.arrow_upward)
                        : Icon(Icons.arrow_downward),
                  ),
                  label: Text(
                    'Doctor Name',
                    style: whitePopSmall,
                  ),
                  backgroundColor: (name) ? Colors.blueAccent : darkCard,
                  onPressed: () {
                    setState(() {
                      if (name) nameAsc = !nameAsc;
                      rating = false;
                      name = true;
                      spec = false;
                    });
                  }),
              ActionChip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: (specAsc)
                        ? Icon(Icons.arrow_upward)
                        : Icon(Icons.arrow_downward),
                  ),
                  label: Text(
                    'Specialization',
                    style: whitePopSmall,
                  ),
                  backgroundColor: (spec) ? Colors.blueAccent : darkCard,
                  onPressed: () {
                    setState(() {
                      if (spec) specAsc = !specAsc;
                      rating = false;
                      name = false;
                      spec = true;
                    });
                  }),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
            itemCount: docs.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return DoctorTile(
                docs: docs[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
