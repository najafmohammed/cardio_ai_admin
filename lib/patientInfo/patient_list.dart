
import 'package:cardio_ai_admin/main.dart';
import 'package:cardio_ai_admin/model/patient_data_model.dart';
import 'package:cardio_ai_admin/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Card(
        color: darkCard,
        child: SizedBox(
          width: (MediaQuery.of(context).size.width / 3) - 30,
          child: Column(
            children: [
              Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "Age",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "OP Number",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "Risk",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "gender",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "Chest Pain",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "Blood Pressure",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "Cholesterol",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "Fasting Blood Sugar",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "Resting ECG",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "Max Heart Rate",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "Exercise Induced Angina",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "ST depression",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "Peak exercise ST",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "Number of major vessels",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "Thal",
                        style: whitePopSmall,
                      ),
                      Divider(),
                    ],
                  ),
                  Container(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "data.name",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        data.entry[0].toString(),
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        "data.opNumber",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        data.prediction.toString(),
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        data.entry[1] == 0 ? "Female" : "Male",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        data.entry[2] == 0
                            ? "Typical Angina"
                            : (data.entry[2] == 1)
                                ? "Atypical Angina"
                                : (data.entry[2] == 2)
                                    ? "Non-Anginal pain"
                                    : "Asymptomatic",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        data.entry[3].toString(),
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        data.entry[4].toString(),
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        data.entry[5] == 0
                            ? "Higher than 120 mg/dl"
                            : "Lower than 120 mg/dl",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        data.entry[6].toString(),
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        data.entry[7].toString(),
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        data.entry[8] == 0 ? "No" : "Yes",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        data.entry[9].toString(),
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        data.entry[10] == 0
                            ? "Up Sloping"
                            : (data.entry[11] == 1)
                                ? "flat"
                                : "Down Sloping",
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        data.entry[11].toString(),
                        style: whitePopSmall,
                      ),
                      Divider(),
                      Text(
                        data.entry[12].toString(),
                        style: whitePopSmall,
                      ),
                      Divider(),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
