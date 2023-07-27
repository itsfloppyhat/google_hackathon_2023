import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_hackathon_2023/auth/auth_page.dart';
//import 'package:google_hackathon_2023/pages/home_page.dart';
import 'package:google_hackathon_2023/pages/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage(currentUser: FirebaseAuth.instance.currentUser.toString(),);
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
