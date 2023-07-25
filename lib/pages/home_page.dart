import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:google_hackathon_2023/pages/music_page.dart';
import 'package:google_hackathon_2023/pages/run_design.dart';
import 'package:google_hackathon_2023/pages/run_history_page.dart';
import 'package:google_hackathon_2023/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;

  void _bottomNavigationBar (int index)
  {
    setState(() {
      _selectedIndex = index;
    });

  }

  final List<Widget> pages = [
    // start run page
    RunDesignPage(),
    // music page
    MusicPage(),
    
    // history page
    RunHistoryPage(),
    SettingsPage()
    // run history pages

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _bottomNavigationBar,
        type: BottomNavigationBarType.fixed,
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.run_circle), label: 'Start Run'),
          BottomNavigationBarItem(icon: Icon(Icons.headphones), label: 'Music'),
          BottomNavigationBarItem(icon: Icon(Icons.view_list_outlined), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ]),
    );
  }
}
