import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_hackathon_2023/pages/feedback_page.dart';

class runHistoryCards extends StatefulWidget {
  final String documentiD;
  runHistoryCards({super.key, required this.documentiD});

  @override
  State<runHistoryCards> createState() => _runHistoryCardsState();
}

var _random = Random();
var coaches = [
  "Yoda",
  "Shrek",
  "Beast Boy",
  "Mermaid Man",
  "Dwayne the Rock Johnson",
  "Kevin Hart",
  "Groot"
];

class _runHistoryCardsState extends State<runHistoryCards> {
  CollectionReference run =
      FirebaseFirestore.instance.collection("run_history");
  var coach = coaches[_random.nextInt(coaches.length)];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: run.doc(widget.documentiD).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: Colors.orange,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date: ${data["Date"]}"),
                    Text(
                        "Duration: ${data["Hours"]}:${data["Minutes"]}: ${data["Seconds"]}"),
                    Text("Steps: ${data["STEPS"]}"),
                    Text("Distance: ${data["DISTANCE"]}"),
                    Text("Heart Rate: ${data["HEART_RATE"]}"),
                    FloatingActionButton.extended(
                      onPressed: () {
                       
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => FeedbackPage(
                                    date: '${data["Date"]}',
                                    duration:
                                        '${data["Hours"]}:${data["Minutes"]}: ${data["Seconds"]}',
                                    steps: '${data["STEPS"]}',
                                    distance: '${data["DISTANCE"]}',
                                    heartRate: '${data["HEART_RATE"]}',
                                    coach: coach)))).then((_) {
                          setState(() {});
                        }).onError((error, stackTrace) {
                          print("ERROR");
                        });
                      },
                      label: Text("Get Feedback"),
                    ),
                  ],
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        }));
  }
}

/*
FutureBuilder<DocumentSnapshot>(
      future: run.doc(documentiD).get(),
      builder: ((context, snapshot){
        if(snapshot.connectionState == ConnectionState.done) {
          Map<String, String> data = snapshot.data!.data() as Map<String, String>;
          return Text("Hello");
        }
        return CircularProgressIndicator();

      }));
  }
}

*/
/*

Container(
      height: 100,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Colors.orange,
      ),
      child: Column(
        children: [
          Text("Date: ", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            
          ),),
          Text("Duration: :,"),
          Text("Steps: "),
          Text("Distance: "),
          Text("Heart Rate: "),

        ],
      ),
    );

*/