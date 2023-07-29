
import 'package:flutter/material.dart';
import 'package:google_hackathon_2023/pages/music_page.dart';
import 'package:google_hackathon_2023/pages/run_design.dart';
import 'package:google_hackathon_2023/pages/run_history_page.dart';
import 'package:google_hackathon_2023/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  final String currentUser;
  const HomePage({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  
   
  int _selectedIndex = 0;
   List<Widget> pages = [ ];

  void _bottomNavigationBar (int index)
  {
    setState(() {
      _selectedIndex = index;
    });

  }
 
  @override
  void initState() {
    // TODO: implement initState
    
    pages = [
      RunDesignPage(),
    // music page
    MusicPage(),
    
    // history page
    RunHistoryPage(),
    SettingsPage()

    ];
    
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _bottomNavigationBar,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.green,
        selectedItemColor: Color.fromARGB(255, 172, 237, 81), // <-- This works for fixed
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.run_circle), label: 'Start Run'),
          BottomNavigationBarItem(icon: Icon(Icons.headphones), label: 'Music'),
          BottomNavigationBarItem(icon: Icon(Icons.view_list_outlined), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ]),
    );
  }
}
