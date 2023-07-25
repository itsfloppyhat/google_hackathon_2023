import 'package:flutter/material.dart';

class StartRun extends StatefulWidget {
  const StartRun({super.key});

  @override
  State<StartRun> createState() => _StartRunState();
}
 int count = 0;
 bool isTrue = true;
Stream<dynamic> generateStream = (() async* {
  while(isTrue)
  {
    await Future.delayed(const Duration(seconds: 1));
    yield count++;
  }

})();

class _StartRunState extends State<StartRun> {

  final int speed = 0;
  final int distance = 0;
  final int time = 0;
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: StreamBuilder(
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

                  GestureDetector(
                    onTap: () {
                      isTrue = !isTrue;
                    },
                    child: Text("Stop")),

                ],
              );
            }
          },
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