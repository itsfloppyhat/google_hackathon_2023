import 'package:flutter/material.dart';

class RunHistoryCards extends StatefulWidget {
  final String mydate, hours,minutes,seconds,steps,distance,heartRate;
  
  const RunHistoryCards({super.key, required this.mydate, required this.hours, required this.minutes, required this.seconds, required this.steps, required this.distance, required this.heartRate});

  @override
  State<RunHistoryCards> createState() => _RunHistoryCardsState();
}

class _RunHistoryCardsState extends State<RunHistoryCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Colors.orange,
      ),
      child: Column(
        children: [
          Text("Date: ${widget.mydate}", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            
          ),),
          Text("Duration: ${widget.hours}:${widget.minutes},${widget.hours}"),
          Text("Steps: ${widget.steps}"),
          Text("Distance: ${widget.distance}"),
          Text("Heart Rate: ${widget.heartRate}"),

        ],
      ),
    );
  }
}