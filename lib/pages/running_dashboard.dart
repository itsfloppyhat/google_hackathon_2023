import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'dart:async';

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
 
 // keep track of entries
 Map <dynamic, dynamic> runData = {

 };
List<double> paces = [];
double totalPaces = 0;
int paceSum = 0;
 double avgPace = 0;
 int count = 0;
 bool isTrue = false;
int ?steps = 0;
int ?speed = 0;
late DateTime startRun;
 String twoDigits(int n) => n.toString().padLeft(2,'0');
List<HealthDataPoint> _healthDataList = [];

// steps and distance
Future fetchStepData() async {

 
HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);
var types = [
    HealthDataType.STEPS,
    HealthDataType.DISTANCE_WALKING_RUNNING,
    HealthDataType.HEART_RATE,
   
  ];

  // get steps for today
  final now = DateTime.now();

  final permission = types.map((e) => HealthDataAccess.READ_WRITE).toList();
  

  bool requested = await health.requestAuthorization(types, permissions: permission);
  if(requested) {
    try{
        steps = await health.getTotalStepsInInterval(DateTime.parse("1969-07-20 20:18:04Z"), now);
       List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(DateTime.parse("1969-07-20 20:18:04Z"), now, types);

          
       
       

    }
    catch(error){
      print("Caught error");
    }
    steps ??= 0;

     print("In fetch data result is  $steps");
    return steps;
  }

  
}



class _RunningDashboardState extends State<RunningDashboard> {
@override

  Duration duration = Duration();
  Timer? timer;
  late Stream sub;
  late Stream averageStream;
  
   // STREAMS
   Stream<dynamic> healthKitStream= (() async* {
  while(isTrue)
  {
    await Future.delayed(Duration(seconds: 3));
    int data =  await fetchStepData();
    print("Data ${data}");
   count++;
    paceSum += data;
   yield data;

}})();

Stream<dynamic> pacePerMinute= (() async* {
  while(isTrue)
  {
    await Future.delayed(Duration(seconds: 5));
    double averagepace = paceSum/count;
    totalPaces += averagepace;
    paces.add(averagepace);
    paceSum = 0;
    count = 0;
    print("Calculating average pace");
    //print(averagepace);
    yield averagepace;
    

}})();
    


  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    setState(() {
      isTrue = true;
    });
   startRun = DateTime.now();
    startTimer();
    
  }
// get data
@override
  void dispose() {
    // TODO: implement dispose
    
    super.dispose();
    timer?.cancel();
  }
void startTimer (){
timer = Timer.periodic(Duration(seconds:1), (_)  =>  addTime());
}

void addTime() {
var addSeconds = 1;
setState(() {
  final seconds = duration.inSeconds + addSeconds;
  duration = Duration(seconds: seconds);
});
}
void stopRun ()
{
  
  isTrue = false;
  final endMinutes = twoDigits(duration.inMinutes.remainder(60));
  final endSeconds = twoDigits(duration.inSeconds.remainder(60));
  final endHours = twoDigits(duration.inHours.remainder(60));
  timer?.cancel();
  Map <dynamic,dynamic> endData = {
"Minutes" : endMinutes,
  "Seconds" : endSeconds,
  "Hours" : endHours,
  };

  runData.addAll(endData);
  

  // end stream
  // send to fire base info;

}
Widget buildTime(){
  // if minutes reach the set time stop timer
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  final hours = twoDigits(duration.inHours.remainder(60));
  return Text('$hours:$minutes:$seconds');
}
void refreshPage ()
{
  setState(() {
    //sub = healthKitStream;
    //averageStream = averagePaceStream;
    startRun = DateTime.now();
    startTimer();
  });
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Column(
          children: [
            // steps, heart rate, distance
            
            StreamBuilder(
              stream: healthKitStream,
              initialData: 0,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return const CircularProgressIndicator();
                }
                else {
                  return Column(
                    children: [
                      Text("Pace: "),
                      Text(snapshot.data.toString()),
                      Text("Distance"),

                      

                    ],
                  );
                }
              },
            ),
            // display average pace
            StreamBuilder(
              stream: pacePerMinute,
              initialData: 0,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                {
                   return const CircularProgressIndicator();
                }
                else
                {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Average Pace per minute: "),
                      Text(snapshot.data.toString()),

                    ],
                  );
                }

            }),
           
              // timer
              
              buildTime(),


// stop button
GestureDetector(
                        onTap: () {
                         print("Run Ended");
                         stopRun();
                         print(runData);
                         timer?.cancel();
                         isTrue = false;
                         refreshPage();
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