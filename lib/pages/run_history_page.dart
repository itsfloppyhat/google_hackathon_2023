import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_hackathon_2023/widgets/runHistoryCards.dart';
class RunHistoryPage extends StatefulWidget {

  const RunHistoryPage({super.key});
  

  @override
  State<RunHistoryPage> createState() => _RunHistoryPageState();
}

class _RunHistoryPageState extends State<RunHistoryPage> {
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
        child: FutureBuilder(
          future: getRunHistory(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting)
            {
              return CircularProgressIndicator();
            }
            else if(snapshot.hasError) {
              return Text("Error");
            }
            else {
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: ((context, index) {
                  return RunHistoryCards(distance: index.toString(), heartRate: index.toString(), hours: index.toString(), minutes: index.toString(), mydate: index.toString(), seconds: index.toString(), steps: index.toString(),);
                  
                }));
            }

        })
      ),
    );
  }
}