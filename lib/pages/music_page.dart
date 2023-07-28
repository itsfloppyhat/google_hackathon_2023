import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_hackathon_2023/widgets/runHistoryCards.dart';
class MusicPage extends StatefulWidget {
  
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User ?user;
  String? uid;

  Map <String,dynamic> myRunHistory = {};
  Future getRunHistory () async {
    await FirebaseFirestore.instance.collection("run_history").where('User', isEqualTo: uid).get().then((snapshot) => snapshot.docs.forEach((element) {
      print(element.reference);
    }));

  }
@override
void initState() {
    // TODO: implement initState
    super.initState();
    user = auth.currentUser;
       uid = user?.uid;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Music page"),

          ],
        ),
        ),
    );
  }
}