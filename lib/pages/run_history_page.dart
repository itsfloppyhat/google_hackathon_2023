import 'package:flutter/material.dart';

class RunHistoryPage extends StatefulWidget {

  const RunHistoryPage({super.key});
  

  @override
  State<RunHistoryPage> createState() => _RunHistoryPageState();
}

class _RunHistoryPageState extends State<RunHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Run History"),
              Text("Run History"),
              Text("Run History"),
            ],
          ),
      ),
    );
  }
}