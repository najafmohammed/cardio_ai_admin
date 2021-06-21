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
TextEditingController _controllerTittle = new TextEditingController();

String msg = "";
String tittle = "";
String hint = "";
String tittleHint = "";
bool visible = false;
String suffixText = "";
Color _textColorIndicator = Colors.grey;
Color _textColorIndicatorTittle = Colors.grey;

List<GlobalMessagingModel> _globalMessages = [];

CollectionReference globalMessageCollection =
    FirebaseFirestore.instance.collection('Global');

bool news = true;
bool tips = false;
bool test = false;
int newsCount = 0;
int tipsCount = 0;
int testCount = 0;

class _GlobalMessageState extends State<GlobalMessage> {
  void updateMessageDisplayed() async {
    QuerySnapshot b;
    if (test) {
      b = await globalMessageCollection
          .doc("Messaging")
          .collection("Test")
          .get();
      _update(b);
    } else if (tips) {
      b = await globalMessageCollection
          .doc("Messaging")
          .collection("Tips")
          .get();
      _update(b);
    } else if (news) {
      b = await globalMessageCollection
          .doc("Messaging")
          .collection("News")
          .get();
      _update(b);
    }
  }

  void _update(QuerySnapshot b) {
    setState(() {
      _globalMessages = b.docs.map((doc) {
        return GlobalMessagingModel(
            tittle: doc.id, text: doc.get("text"), uid: doc.id);
      }).toList();
    });
  }

  void GetData() async {
    await globalMessageCollection
        .doc("Messaging")
        .collection("News")
        .get()
        .then((value) {
      setState(() {
        newsCount = value.docs.length;
      });
    });
    await globalMessageCollection
        .doc("Messaging")
        .collection("Test")
        .get()
        .then((value) {
      setState(() {
        testCount = value.docs.length;
      });
    });
    await globalMessageCollection
        .doc("Messaging")
        .collection("Tips")
        .get()
        .then((value) {
      setState(() {
        tipsCount = value.docs.length;
      });
    });
    updateMessageDisplayed();
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
                  updateMessageDisplayed();
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
                  updateMessageDisplayed();
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
                  updateMessageDisplayed();
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
                  controller: _controllerTittle,
                  onChanged: (val) {
                    setState(() => tittle = val);
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
                        (tittle == "") ? Icons.circle : Icons.check_circle,
                        color: (tittle == "")
                            ? Colors.red
                            : _textColorIndicatorTittle,
                      ),
                    ),
                    hintText: (tittleHint == "")
                        ? (news)
                            ? 'Enter tittle for News'
                            : (tips)
                                ? 'Enter tittle for Tips'
                                : 'Enter tittle for Tests'
                        : tittleHint,
                    hintStyle: TextStyle(
                        color: (tittleHint == "") ? Colors.grey : Colors.red),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Tittle',
                    labelStyle:
                        new TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  cursorColor: Colors.white,
                ),
              ),
            ],
          ),
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
                    hintText: (hint == "")
                        ? (news)
                            ? 'Enter message for News'
                            : (tips)
                                ? 'Enter message for Tips'
                                : 'Enter message for Tests'
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
            ],
          ),
        ),
        Center(
          child: Card(
            color: darkCard,
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {});
                    if (msg == "" || tittle == "") {
                      setState(() {
                        hint = "Write something ";
                        tittleHint = "Write something ";
                        _textColorIndicator = Colors.red;
                      });
                    } else {
                      visible = !visible;
                      setState(() {
                        suffixText = "message sent";
                      });
                      _textColorIndicator = Colors.green;
                      globalMessageCollection.doc();
                      final CollectionReference record =
                          FirebaseFirestore.instance.collection('Global');
                      if (test)
                        await record.doc("Messaging").collection("Test").doc(tittle).set({
                          "text": msg,
                        }).then((value) {
                          setState(() {
                            visible = !visible;
                            msg = "";
                            tittle = "";
                            suffixText = "";
                            _controller.clear();
                            _controllerTittle.clear();
                          });
                          GetData();
                        });
                      if (tips)
                        await record.doc("Messaging").collection("Tips").doc(tittle).set({
                          "text": msg,
                        }).then((value) {
                          setState(() {
                            visible = !visible;
                            msg = "";
                            tittle = "";
                            suffixText = "";
                            _controller.clear();
                            _controllerTittle.clear();
                          });
                          GetData();
                        });
                      if (news)
                        await record.doc("Messaging").collection("News").doc(tittle).set({
                          "text": msg,
                        }).then((value) {
                          setState(() {
                            visible = !visible;
                            msg = "";
                            tittle = "";
                            suffixText = "";
                            _controller.clear();
                            _controllerTittle.clear();
                          });
                          GetData();
                        });
                    }
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                  label: Text(
                    "Submit",
                    style: whitePopSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: (MediaQuery.of(context).size.width / 3) - 90,
          height: (MediaQuery.of(context).size.height / 1.8),
          child: GlobalMessagingList(
            updateCount: (){
              GetData();
            },
            news: news,
            tips: tips,
            test: test,
            messages: _globalMessages,
            patientUid: widget.patientUid,
          ),
        )
      ],
    );
  }
}
