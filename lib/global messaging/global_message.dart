import 'package:cardio_ai_admin/global%20messaging/global_messaging_list.dart';
import 'package:cardio_ai_admin/model/globalMessagingModel.dart';
import 'package:cardio_ai_admin/shared/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GlobalMessage extends StatefulWidget {
  final String patientUid;

  const GlobalMessage({Key? key, required this.patientUid}) : super(key: key);
  @override
  _GlobalMessageState createState() => _GlobalMessageState();
}

TextEditingController _controller = new TextEditingController();
String msg = "";
String hint = "";
bool visible = false;
String suffixText = "";
Color _textColorIndicator = Colors.grey;
bool _reminderVisibility = false;

List<GlobalMessagingModel> _globalMessages = [];

CollectionReference globalMessageCollection =
    FirebaseFirestore.instance.collection('Global');

bool news = false;
bool tips = false;
bool test = false;
int newsCount = 0;
int tipsCount = 0;
int testCount = 0;

class _GlobalMessageState extends State<GlobalMessage> {
  void GetData() async {
    await globalMessageCollection
        .doc("Messaging")
        .collection("Test")
        .get()
        .then((value) {
          print("hello");
print(value.size);
      setState(() {
        newsCount = value.docs.length;
      });
    });
  }

  initState() {
    GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Global Messaging",
            style: whitePopLarge(Colors.white),
          ),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Type ",
              style: whitePopSmall,
            ),
            ActionChip(
                avatar: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: Text(
                      newsCount.toString(),
                      style: whitePopSmall,
                    )),
                label: Text(
                  'News',
                  style: whitePopSmall,
                ),
                backgroundColor: (news) ? Colors.blueAccent : darkCard,
                onPressed: () {
                  setState(() {
                    news = true;
                    tips = false;
                    test = false;
                  });
                }),
            ActionChip(
                avatar: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: Text(
                      tipsCount.toString(),
                      style: whitePopSmall,
                    )),
                label: Text(
                  'Tips',
                  style: whitePopSmall,
                ),
                backgroundColor: (tips) ? Colors.blueAccent : darkCard,
                onPressed: () {
                  setState(() {
                    news = false;
                    tips = true;
                    test = false;
                  });
                }),
            ActionChip(
                avatar: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: Text(
                      testCount.toString(),
                      style: whitePopSmall,
                    )),
                label: Text(
                  'Tests ',
                  style: whitePopSmall,
                ),
                backgroundColor: (test) ? Colors.blueAccent : darkCard,
                onPressed: () {
                  setState(() {
                    news = false;
                    tips = false;
                    test = true;
                  });
                }),
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
                        color: (msg == "") ? Colors.red : _textColorIndicator,
                      ),
                    ),
                    hintText:
                        (hint == "") ? 'Enter message for Reminder' : hint,
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
                    final CollectionReference record =
                        FirebaseFirestore.instance.collection('Patient Record');
                    await record.doc().collection("Reminders").add({
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
                    var b = await globalMessageCollection
                        .doc("Messaging")
                        .collection("Test")
                        .get();
                    setState(() {
                      _globalMessages = b.docs.map((doc) {
                        return GlobalMessagingModel(tittle: doc.id,
                            text: doc.get("text"), uid: doc.id);
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
        (_reminderVisibility)
            ? SizedBox(
                width: (MediaQuery.of(context).size.width / 3) - 90,
                height: (MediaQuery.of(context).size.height / 1.65),
                child: GlobalMessagingList(
                  messages: _globalMessages,
                  patientUid: widget.patientUid,
                ),
              )
            : Center(
                child: SizedBox(
                  width: (MediaQuery.of(context).size.width / 3) - 90,
                  child: Card(
                    color: darkCard,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info,color: Colors.white,),
                              Text(
                                "Choose type and click on visibility ",
                                style: whitePopLarge(Colors.white),
                                maxLines: 3,
                              ),
                            ],
                          ),
                          Text(
                            "icon to show current messages",
                            style: whitePopLarge(Colors.white),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
