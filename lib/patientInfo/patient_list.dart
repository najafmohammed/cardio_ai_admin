import 'package:cardio_ai_admin/main.dart';
import 'package:cardio_ai_admin/model/infoGrid.dart';
import 'package:cardio_ai_admin/model/patient_data_model.dart';
import 'package:cardio_ai_admin/shared/colors.dart';
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
  @override
  Widget build(BuildContext context) {
    final PatientRecord = Provider.of<List<PatientDataModel>>(context);
    PatientDataModel data = PatientRecord[index];
    PatientRecord.forEach((element) {
      print(element.name);
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
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 65,
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
                          radius: 60.0,
                        ),
                      ),
                      Text(
                        data.name + " (" + data.entry[0].toString() + ")",
                        style: whitePopSmall,
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
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
              SizedBox(
                width: (MediaQuery.of(context).size.width / 3) - 50,
                height: (MediaQuery.of(context).size.height / 1.6),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 6,
                  itemCount: gridData.length,
                  itemBuilder: (BuildContext context, int index) => Card(
                    color: Colors.purple.shade400,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          new Text(
                            gridData[index].title.toString(),
                            style: whitePopSmall,
                          ),
                          Divider(
                            color: Colors.purple.shade400,
                          ),
                          new Text(
                            gridData[index].value.toString(),
                            style:
                                whitePopSmall.copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                  staggeredTileBuilder: (int index) => new StaggeredTile.count(
                      gridData[index].column, gridData[index].row.toDouble()),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              ),
            ],
          ),
        ));
  }
}
