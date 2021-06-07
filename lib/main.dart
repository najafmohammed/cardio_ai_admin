import 'package:cardio_ai_admin/doctorPanel/doctor_list.dart';
import 'package:cardio_ai_admin/model/patient_data_model.dart';
import 'package:cardio_ai_admin/patientInfo/patient_list.dart';
import 'package:cardio_ai_admin/patientRecord/patientfeed.dart';
import 'package:cardio_ai_admin/shared/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cardio AI',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Cardio AI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
int index=0;
class _MyHomePageState extends State<MyHomePage> {
  void getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int _index = (prefs.getInt('index') ?? 0);
    setState(() {
      index=_index;
    });
  }
   initState() {
     getData();
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Patient List',
                    style: whitePopLarge(Colors.white),
                  ),
                ),
                PatientList()
              ],
            ),
            Column(
              children: [
                StreamProvider<List<PatientDataModel>>.value(
                    value: getpatientFeedPrediction,
                    initialData: [PatientDataModel("null",1,2,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])],
                    child: PatientInfoList(index)),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Doctor Panel',
                    style: whitePopLarge(Colors.white),
                  ),
                ),
                DoctorList()
              ],
            )
          ],
        ),
      ),
    );
  }
}
