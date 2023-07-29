import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'dart:async';
import 'package:google_hackathon_2023/widgets/healthcard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/*
REQUIREMENTS
- calculate average pace every 25 seconds
- if average pace is +/- 10 difference, go to palm and get new song based on pace
- build a streamn for the health ui kit to get new data every 3 seconds
- when run is stopped, get data and send it to the database
*/

class RunningDashboard extends StatefulWidget {
  final int hour;
  final int minute;
  final int second;
  final double miles;
  final String pace;
  const RunningDashboard(
      {super.key,
      required this.hour,
      required this.minute,
      required this.second,
      required this.miles,
      required this.pace});

  @override
  State<RunningDashboard> createState() => _RunningDashboardState();
}

double fixedDistance = 0;
double distance = 0;
Map<String, String> trackRunData = {};
List<double> averageBpmList = [];
double bpm = 0;
double paceSum = 0;
double avgPace = 0;
double count = 0;
bool isTrue = false;
int? steps = 0;
int? speed = 0;
double distanceTest = 0;
double stepsTest = 0;
int heartRate = 80;
late DateTime startRun;
String twoDigits(int n) => n.toString().padLeft(2, '0');

YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId: "tJYLSNYGM7I", flags: YoutubePlayerFlags(autoPlay: true));
List<String> youtubeLinks = [
  "https://www.youtube.com/watch?v=d8OL6m0ZblA",
  "https://www.youtube.com/watch?v=EfZPNF8xQ6Y",
  "https://www.youtube.com/watch?v=tJYLSNYGM7I",
];

List<HealthDataPoint> _healthDataList = [];

// steps and distance
Future fetchData() async {
  HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);
  List<HealthDataType> types = [
    HealthDataType.STEPS,
    HealthDataType.DISTANCE_WALKING_RUNNING,
    HealthDataType.HEART_RATE,
  ];

  Map<String, String> health_data = {};

  // get steps for today
  final now = DateTime.now();
  print("Start run time is $startRun");
  final permission = types.map((e) => HealthDataAccess.READ_WRITE).toList();

  bool requested =
      await health.requestAuthorization(types, permissions: permission);
  if (requested) {
    try {
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(startRun, now, types);

      if (healthData.isNotEmpty) {
        for (HealthDataPoint h in healthData) {
          if (h.type == HealthDataType.HEART_RATE) {
            health_data["HEART_RATE"] = "${h.value}";
            trackRunData["HEART_RATE"] = "${h.value}";
          } else if (h.type == HealthDataType.DISTANCE_WALKING_RUNNING) {
            health_data["DISTANCE"] = "${h.value}";
            trackRunData["DISTANCE"] = "${h.value}";
          } else if (h.type == HealthDataType.STEPS) {
            health_data["STEPS"] = "${h.value}";
            trackRunData["STEPS"] = "${h.value}";
          }
        }
      } else {
        health_data["HEART_RATE"] = "0";
        trackRunData["HEART_RATE"] = "0";
        health_data["DISTANCE"] = "0";
        trackRunData["DISTANCE"] = "0";
        health_data["STEPS"] = "0";
        trackRunData["STEPS"] = "0";
      }
    } catch (error) {
      print("Caught error");
      return health_data;
    }

    return health_data;
  }
}

class _RunningDashboardState extends State<RunningDashboard> {
  @override
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  String? uid;
  Duration duration = Duration();
  Timer? timer;
  //late YoutubePlayerController controller;
  Stream<dynamic> youTubeStream = (() async* {
    while (isTrue) {
      int index = count.round() % 3;
      print("at index $index");
      String links = youtubeLinks[index];
      String? videoID = YoutubePlayer.convertUrlToId(links);
      videoID ??= "EfZPNF8xQ6Y";
      print("Video id is $videoID");
      controller.load(videoID);
      await Future.delayed(Duration(seconds: 20));
      yield (isTrue) ? controller : null;
    }
    yield (isTrue) ? controller : throw "Error";
  })();

  Stream<dynamic> healthKitStream = (() async* {
    while (isTrue) {
      Map<String, String> streamData = {};

      await Future.delayed(Duration(seconds: 1));
      streamData = await fetchData();
      print("Received data in healthkitStream $streamData");

      if (streamData.isNotEmpty) {
        String? check = streamData["STEPS"];

        var mysteps = double.tryParse(check!);
        if (mysteps != null) {
          //print("Success!");
          paceSum += stepsTest;
        } else {
          print("Failure!");
          paceSum = 0;
        }
        fixedDistance = double.parse((distanceTest).toStringAsFixed(3));
        distanceTest = fixedDistance;
        streamData["STEPS"] = stepsTest.toString();
        streamData["HEART_RATE"] = heartRate.toString();
        streamData["DISTANCE"] = fixedDistance.toString();
        streamData["BPM"] = bpm.toString();
        // put here if distance is equal to goal distance. if true make distance reached true
      }
      stepsTest++;
      if (heartRate < 120) {
        heartRate++;
      } else {
        heartRate--;
      }

      distanceTest += 0.01;

      count++;
      yield streamData;
    }
  })();

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
        initialVideoId: "tJYLSNYGM7I",
        flags: YoutubePlayerFlags(autoPlay: true));
    // TODO: implement initState
    distanceTest = 0;
    stepsTest = 0;
    heartRate = 80;
    user = auth.currentUser;
    uid = user?.uid;
    isTrue = true;
    bpm = 0;
    paceSum = 0;
    count = 0;
    startRun = DateTime.now();
    startTimer();
    calculateBpm();
  }

// get data
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    timer?.cancel();
    controller.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    var addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  Future stopRun() async {
    //isTrue = false;
    final endMinutes = twoDigits(duration.inMinutes.remainder(60));
    final endSeconds = twoDigits(duration.inSeconds.remainder(60));
    final endHours = twoDigits(duration.inHours.remainder(60));

    Map<String, String> endData = {
      "Minutes": endMinutes,
      "Seconds": endSeconds,
      "Hours": endHours,
      "User": uid!,
      "Date": DateTime.now().toString(),
      "DISTANCE": fixedDistance.toString(),
      "HEART_RATE": heartRate.toString(),
      "STEPS": stepsTest.toString(),
    };
    print(endData);

    await FirebaseFirestore.instance.collection("run_history").add(endData);
    print("Run ended total Stats");

    // end stream
    // send to fire base info;
  }

  void calculateBpm() async {
    while (isTrue) {
      await Future.delayed(Duration(seconds: 60));
      // calculate bpm

      bpm = count * 2;
      count = 0;
      paceSum = 0;
      averageBpmList.add(bpm);
    }
  }

  Widget buildTime() {
    // if minutes reach the set time stop timer
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = twoDigits(duration.inHours.remainder(60));
    return Text(
      'Duration: $hours:$minutes:$seconds',
      style: TextStyle(
        fontSize: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: [
            // timer
            SizedBox(height: 50),
            Center(child: buildTime()),

            SizedBox(height: 20),

            // youtube player goes here
            StreamBuilder(
              stream: youTubeStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.active &&
                    isTrue == true) {
                  print((snapshot.connectionState == ConnectionState.active));
                  return SizedBox(
                      height: 200,
                      width: 150,
                      child: YoutubePlayer(controller: snapshot.data));
                } else {
                  return Text("Error");
                }
              },
            ),

            // cards to display data
            SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: StreamBuilder(
                stream: healthKitStream,
                initialData: 0,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      crossAxisCount: 2,
                      childAspectRatio: (1 / .7),
                      children: [
                        HealthCard(
                            title: "Steps",
                            displayData: snapshot.data.toString(),
                            color: Colors.green,
                            image: "lib/images/step.png"),
                        HealthCard(
                            title: "Distance",
                            displayData: snapshot.data.toString(),
                            color: Colors.green,
                            image: "lib/images/distance.png"),
                        HealthCard(
                            title: "Heart Rate",
                            displayData: snapshot.data.toString(),
                            color: Colors.green,
                            image: "lib/images/heart.png"),
                        HealthCard(
                            title: "BPM",
                            displayData: snapshot.data.toString(),
                            color: Colors.green,
                            image: "lib/images/chronometer.png"),
                      ],
                    );
                  } else if (snapshot.connectionState ==
                          ConnectionState.active &&
                      isTrue == true) {
                    return GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      crossAxisCount: 2,
                      childAspectRatio: (1 / .7),
                      children: [
                        HealthCard(
                            title: "Steps",
                            displayData: snapshot.data["STEPS"],
                            color: Colors.green,
                            image: "lib/images/step.png"),
                        HealthCard(
                            title: "Distance",
                            displayData: snapshot.data["DISTANCE"],
                            color: Colors.green,
                            image: "lib/images/distance.png"),
                        HealthCard(
                            title: "Heart Rate",
                            displayData: snapshot.data["HEART_RATE"],
                            color: Colors.green,
                            image: "lib/images/heart.png"),
                        HealthCard(
                            title: "BPM",
                            displayData: snapshot.data["BPM"],
                            color: Colors.green,
                            image: "lib/images/chronometer.png"),
                      ],
                    );
                  } else {
                    return Text("Error");
                  }
                },
              ),
            ),

            // stop button
            Center(
              child: GestureDetector(
                  onTap: () {
                    //dispose();
                    isTrue = false;
                    Navigator.pop(context);
                    stopRun();
                    timer?.cancel();

                    // get current data and send to firebase
                    // then go to run history
                  },
                  child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Text(
                        "End Workout",
                        textAlign: TextAlign.center,
                      )))),
            ),
          ],
        ),
      )),
    );
  }
}
