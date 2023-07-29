import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_hackathon_2023/pages/running_dashboard.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class FeedbackPage extends StatefulWidget {
  final String date;
  final String duration;
  final String steps;
  final String distance;
  final String heartRate;
  final String coach;

  const FeedbackPage(
      {super.key,
      required this.date,
      required this.duration,
      required this.steps,
      required this.distance,
      required this.heartRate,
      required this.coach});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late Future<PalmPrompt> futurePalmPrompt;
  Future<PalmPrompt> getFeedback() async {
    //String toParse = "";
    final response = await http.get(Uri.parse(
        'http://localhost:8080/promptfb?prompt=I ran ${widget.distance} in ${widget.duration} on ${widget.date}. My step count was ${widget.steps} and my heart rate was ${widget.heartRate} Give me some feedback on my run like you were my coach named ${widget.coach}'));

    if (response.statusCode == 200) {
      return PalmPrompt.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePalmPrompt = getFeedback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: SafeArea(
          child: Center(
            child: FutureBuilder<PalmPrompt>(
              future: futurePalmPrompt,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back)),
                        ],
                      ),
                      Text(snapshot.data!.feedback),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('$snapshot.error');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class PalmPrompt {
  final String feedback;

  const PalmPrompt({required this.feedback});
  factory PalmPrompt.fromJson(Map<String, dynamic> json) {
    return PalmPrompt(feedback: json['feedback']);
  }
}
