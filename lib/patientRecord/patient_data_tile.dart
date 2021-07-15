import 'package:cardio_ai_admin/model/patient_data_model.dart';
import 'package:cardio_ai_admin/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientTile extends StatefulWidget {
  final PatientDataModel model;
  final int masterIndex;

  const PatientTile(this.model, this.masterIndex);
  @override
  _PatientTileState createState() => _PatientTileState();
}

void updateUser(int val) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('index', val);
}

int index = 0;

class _PatientTileState extends State<PatientTile> {
  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        updateUser(widget.model.opNumber);
        print("value :"+widget.masterIndex.toString());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Card(
          color: darkCard,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (widget.model.prediction != 0)
                  ? Text(
                      widget.model.name,
                      style: whitePopLarge(Colors.white),
                    )
                  : Text(
                      widget.model.name,
                      style: whitePopLarge(Colors.white),
                    ),
            ),
            leading: CircleAvatar(
              child: Image(
                image: (widget.model.entry[1] == 1)
                    ? AssetImage("assets/male.png")
                    : AssetImage("assets/female.png"),
              ),
              radius: 30,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (widget.model.prediction != 0)
                  ? Text(
                      "#" + widget.model.opNumber.toString(),
                      style: whitePopLarge(Colors.white70),
                    )
                  : Text(""),
            ),
            trailing: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (widget.model.prediction != 0)
                  ? Text(
                    (widget.model.prediction * 100).toString() + " %",
                    style:
                        whitePopLarge((widget.model.prediction <= .40)
                            ? Colors.green
                            : (widget.model.prediction > 40 && widget.model.prediction <= .90)
                            ? Colors.orange
                            : Colors.red,),
                  )
                  : Text(""),
            ),
          ),
        ),
      ),
    );
  }
}
