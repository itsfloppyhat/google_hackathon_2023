import 'package:flutter/material.dart';
import 'package:health/health.dart';

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
  const RunningDashboard({super.key, required this.hour, required this.minute, required this.second, required this.miles, required this.pace});

  @override
  State<RunningDashboard> createState() => _RunningDashboardState();
}
 
 int count = 0;
 bool isTrue = true;
int ?steps = 0;
int ?speed = 0;
late DateTime startRun;
Future fetchStepData() async {
  

HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);
var types = [
    HealthDataType.STEPS,
   
  ];

  // get steps for today
  final now = DateTime.now();

  var permission = [HealthDataAccess.READ];

  bool requested = await health.requestAuthorization(types, permissions: permission);
  if(requested) {
    try{
        steps = await health.getTotalStepsInInterval(startRun, now);

    }
    catch(error){
      print("Caught error");
    }
    return steps;
  }

  
}



List<int> paces = [];

class _RunningDashboardState extends State<RunningDashboard> {
@override
  void initState() {
    // TODO: implement initState
    startRun = DateTime.now();
  }
// get data
@override
  void dispose() {
    // TODO: implement dispose
    
    super.dispose();
  }
  final int distance = 0;
  final int time = 0;
 

Stream<dynamic> generateStream = (() async* {
  while(isTrue)
  {
    await Future.delayed(const Duration(seconds: 3));
    // get data from health ui kit
    speed = await fetchStepData();
    // set data to class variables
    // return data from kit
   
    

    yield speed;
  }

})();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Column(
          children: [
            StreamBuilder(
              stream: generateStream,
              initialData: 0,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return const CircularProgressIndicator();
                }
                else if(snapshot.hasError){
                  return Text("Error");
                }
                else {
                  return Column(
                    children: [
                      Text("Speed: "),
                      Text(snapshot.data.toString()),
                      Text("Distance"),

                      

                    ],
                  );
                }
              },
            ),
// stop button
GestureDetector(
                        onTap: () {
                          isTrue = !isTrue;
                          print("Speed history");
                          print(paces);
                          Navigator.pop(context);
                          // get current data and send to firebase
                          // then go to run history
                        },
                        child: Text("Stop")),


          ],
        ),
        
      )),
    );
  }
}

/*
Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // speed
            Text("Speed ${speed.toString()}"),
            //distance
             Text("Distance"),
            // pace
             Text("Pace"),
            // timer
             Text("Time"),
            //end run
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text("End Run")),
      
          ],
        ),



*/