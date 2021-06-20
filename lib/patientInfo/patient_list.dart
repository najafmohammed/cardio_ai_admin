import 'package:cardio_ai_admin/main.dart';
import 'package:cardio_ai_admin/model/infoGrid.dart';
import 'package:cardio_ai_admin/model/patient_data_model.dart';
import 'package:cardio_ai_admin/model/reminderModel.dart';
import 'package:cardio_ai_admin/patientInfo/reminders/reminderList.dart';
import 'package:cardio_ai_admin/shared/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PatientInfoList extends StatefulWidget {
  PatientInfoList(int index);

  @override
  _PatientInfoListState createState() => _PatientInfoListState();
}

class _PatientInfoListState extends State<PatientInfoList> {
  String msg = "";
  String hint = "";
  bool visible = false;
  String suffixText = "";
  Color _textColorIndicator = Colors.grey;
  bool _reminderVisibility = false;
  TextEditingController _controller = new TextEditingController();

  List<reminderModel> reminderData = [];

  CollectionReference recordPredictionReminder =
      FirebaseFirestore.instance.collection('Patient Record');

  @override
  Widget build(BuildContext context) {
    final PatientRecord = Provider.of<List<PatientDataModel>>(context);
    PatientDataModel data = PatientRecord[index];
    PatientRecord.forEach((element) {
      // print(element.name);
    });

    List<InfoGrid> gridData = [
      InfoGrid(
        row: 1.2,
        column: 2,
        title: "Chest Pain",
        value: data.entry[2] == 0
            ? "Typical Angina"
            : (data.entry[2] == 1)
                ? "Atypical Angina"
                : (data.entry[2] == 2)
                    ? "Non-Anginal pain"
                    : "Asymptomatic",
      ),
      InfoGrid(
        row: 1.2,
        column: 2,
        title: "Blood Pressure",
        value: data.entry[3].toString(),
      ),
      InfoGrid(
        row: 1.2,
        column: 2,
        title: "Cholesterol",
        value: data.entry[4].toString(),
      ),
      InfoGrid(
        row: 1.2,
        column: 4,
        title: "Fasting Blood Sugar",
        value: data.entry[5] == 0
            ? "Higher than 120 mg/dl"
            : "Lower than 120 mg/dl",
      ),
      InfoGrid(
        row: 1.2,
        column: 2,
        title: "Resting ECG",
        value: data.entry[6].toString(),
      ),
      InfoGrid(
        row: 1.2,
        column: 2,
        title: "Max Heart Rate",
        value: data.entry[7].toString(),
      ),
      InfoGrid(
        row: 1.2,
        column: 4,
        title: 'Exercise Induced Angina',
        value: data.entry[8] == 0 ? "No" : "Yes",
      ),
      InfoGrid(
        row: 1.2,
        column: 2,
        title: "ST depression",
        value: data.entry[9].toString(),
      ),
      InfoGrid(
        row: 1.2,
        column: 4,
        title: "Peak exercise ST",
        value: data.entry[10] == 0
            ? "Up Sloping"
            : (data.entry[11] == 1)
                ? "flat"
                : "Down Sloping",
      ),
      InfoGrid(
        row: 1.2,
        column: 4,
        title: "Number of major vessels",
        value: data.entry[11].toString(),
      ),
      InfoGrid(
        row: 1.2,
        column: 2,
        title: "Thal",
        value: data.entry[12].toString(),
      ),
    ];

    return Card(
        color: darkCard,
        child: SizedBox(
          width: (MediaQuery.of(context).size.width / 3) - 30,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Patient #" + data.opNumber.toString(),
                      style: whitePopLarge(Colors.white),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: (data.prediction <= .40)
                        ? Colors.green
                        : (data.prediction > 40 && data.prediction <= .90)
                            ? Colors.orange
                            : Colors.red,
                    child: CircleAvatar(
                      child: Image(
                        image: (data.entry[1] == 1)
                            ? AssetImage("assets/male.png")
                            : AssetImage("assets/female.png"),
                      ),
                      radius: 50.0,
                    ),
                  ),
                  Text(
                    data.name + " (" + data.entry[0].toString() + ")",
                    style: whitePopSmall,
                  ),
                  Text(
                    (data.prediction * 100).toString() + " %",
                    style: whitePopLarge((data.prediction <= .40)
                        ? Colors.green
                        : (data.prediction > 40 && data.prediction <= .90)
                            ? Colors.orange
                            : Colors.red),
                  ),
                ],
              ),
              Card(
                color: darkCard,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    new Container(
                      height: 75,
                      width: 340,
                      child: new TextFormField(
                        controller: _controller,
                        onChanged: (val) {
                          setState(() => msg = val);
                        },
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: new InputDecoration(
                          suffixText: suffixText,
                          suffixIcon: AnimatedOpacity(
                            opacity: visible ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 1000),
                            // The green box must be a child of the AnimatedOpacity widget.
                            child: Icon(
                              (msg == "") ? Icons.circle : Icons.check_circle,
                              color: (msg == "")
                                  ? Colors.red
                                  : _textColorIndicator,
                            ),
                          ),
                          hintText: (hint == "")
                              ? 'Enter message for Reminder'
                              : hint,
                          hintStyle: TextStyle(
                              color: (hint == "") ? Colors.grey : Colors.red),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: 'Message',
                          labelStyle:
                              new TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        cursorColor: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        setState(() {});
                        if (msg == "") {
                          setState(() {
                            hint = "Write something ";
                            _textColorIndicator = Colors.red;
                          });
                        } else {
                          visible = !visible;
                          setState(() {
                            suffixText = "message sent";
                          });
                          print("sending msg:" + msg);
                          _textColorIndicator = Colors.green;
                          final CollectionReference record = FirebaseFirestore
                              .instance
                              .collection('Patient Record');
                          await record
                              .doc(data.uid)
                              .collection("Reminders")
                              .add({
                            "msg": msg,
                          }).then((value) {
                            setState(() {
                              visible = !visible;
                              msg = "";
                              suffixText = "";
                              _controller.clear();
                            });
                          });
                        }
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                      label: Text(
                        "",
                        style: whitePopSmall,
                      ),
                    ),
                    ElevatedButton.icon(
                        onPressed: () async {
                          var b = await recordPredictionReminder
                              .doc(data.uid)
                              .collection("Reminders")
                              .get();
                          setState(() {
                            reminderData = b.docs.map((doc) {
                              return reminderModel(
                                  text: doc.get("msg"), uid: doc.id);
                            }).toList();

                            _reminderVisibility = !_reminderVisibility;
                          });
                        },
                        icon: (_reminderVisibility)
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        label: Text("")),
                  ],
                ),
              ),
              (!_reminderVisibility)
                  ? SizedBox(
                      width: (MediaQuery.of(context).size.width / 3) - 90,
                      height: (MediaQuery.of(context).size.height / 1.65),
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 6,
                        itemCount: gridData.length,
                        itemBuilder: (BuildContext context, int index) => Card(
                          color: Colors.purple.shade400,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: new Text(
                                  gridData[index].title.toString(),
                                  style: whitePopSmall,
                                ),
                              ),
                              Divider(
                                color: Colors.purple.shade400,
                              ),
                              new Text(
                                gridData[index].value.toString(),
                                style: whitePopSmall.copyWith(
                                    color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.count(gridData[index].column,
                                gridData[index].row.toDouble()),
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                      ),
                    )
                  : SizedBox(
                      width: (MediaQuery.of(context).size.width / 3) - 90,
                      height: (MediaQuery.of(context).size.height / 1.65),
                      child: ReminderList(patientUid: data.uid,
                        reminders: reminderData,
                      ))
            ],
          ),
        ));
  }
}
