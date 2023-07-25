import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:google_hackathon_2023/home_screens/run_design.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      pages: [
        (_) => RunDesignPage(),
        (_) => Center(child: Text("Feedback page goes here")),
      ],
      bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => onTap(index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.run_circle), label: 'Run'),
          BottomNavigationBarItem(
              icon: Icon(Icons.linear_scale), label: 'Feedback')
        ],
      ),
    );
  }
}
