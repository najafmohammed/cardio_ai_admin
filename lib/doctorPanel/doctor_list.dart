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
String query="";

List<DoctorModel> mod = [
  DoctorModel(rating: 0,name: "Not found",specialization: ""),
];
class _DoctorListState extends State<DoctorList> {

  @override
  Widget build(BuildContext context) {

//docs
    List<DoctorModel> docs = [
      DoctorModel(rating: 4, name: "doc 1", specialization: "spec 1"),
      DoctorModel(rating: 3, name: "doc 2", specialization: "spec 2"),
      DoctorModel(rating: 5, name: "doc 3", specialization: "spec 3"),
      DoctorModel(rating: 3, name: "doc 4", specialization: "spec 4"),
      DoctorModel(rating: 3, name: "doc 5", specialization: "spec 5"),
      DoctorModel(rating: 2, name: "doc 6", specialization: "spec 6"),
      DoctorModel(rating: 4, name: "doc 7", specialization: "spec 7"),
      DoctorModel(rating: 3, name: "doc 8", specialization: "spec 8"),
      DoctorModel(rating: 2, name: "doc 9", specialization: "spec 9"),
    ];
    if (rating == true && ratingAsc == true) {
      docs.sort((a, b) => a.rating.compareTo(b.rating));
      if (query != "") {
        docs = docs.where((element) => element.rating.toString()
            .toLowerCase()
            .contains(query.toLowerCase())).toList();
      }
      if (docs.isEmpty) {
        docs =mod;
      }
    }
    if (rating == true && ratingAsc == false) {
      docs.sort((b, a) => a.rating.compareTo(b.rating));
      if (query != "") {
        docs = docs.where((element) => element.rating.toString()
            .toLowerCase()
            .contains(query.toLowerCase())).toList();
      }
      if (docs.isEmpty) {
        docs =mod;
      }
    }
    if (name == true && nameAsc == true) {
      docs.sort((a, b) => a.name.compareTo(b.name));
      if (query != "") {
        docs = docs.where((element) => element.name
            .toLowerCase()
            .contains(query.toLowerCase())).toList();
      }
      if (docs.isEmpty) {
        docs =mod;
      }
    }
    if (name == true && nameAsc == false) {
      docs.sort((b, a) => a.name.compareTo(b.name));
      if (query != "") {
        docs = docs.where((element) => element.name
            .toLowerCase()
            .contains(query.toLowerCase())).toList();
      }
      if (docs.isEmpty) {
        docs =mod;
      }
    }
    if (spec == true && specAsc == true) {
      docs.sort((a, b) => a.specialization.compareTo(b.specialization));
      if (query != "") {
        docs = docs.where((element) => element.specialization
            .toLowerCase()
            .contains(query.toLowerCase())).toList();
      }
      if (docs.isEmpty) {
        docs =mod;
      }
    }
    if (spec == true && specAsc == true) {
      docs.sort((b, a) => a.specialization.compareTo(b.specialization));
      if (query != "") {
        docs = docs.where((element) => element.specialization
            .toLowerCase()
            .contains(query.toLowerCase())).toList();
      }
      if (docs.isEmpty) {
        docs =mod;
      }
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
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: TextField(
              cursorColor: Colors.white,
              onChanged: (val) {
                setState(() {
                  query=val;
                });
                print(val);
              },style: whitePopLarge(Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                labelText: 'Search',
                labelStyle: whitePopLarge(Colors.white),
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.4,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: docs.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  return DoctorTile(
                    docs: docs[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
