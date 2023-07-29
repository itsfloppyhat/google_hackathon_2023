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
  List<String> docIDs = [];

  Future getDocIds() async {
    print("Im called");
    await FirebaseFirestore.instance.collection("run_history").get().then(
      (snapshot) => snapshot.docs.forEach((document) {
        print(document.reference);
        docIDs.add(document.reference.id);
      }),);

  }

 

@override
void initState() {
    // TODO: implement initState
    super.initState();
    user = auth.currentUser;
       uid = user?.uid;
       //_runHistoryStream =  FirebaseFirestore.instance.collection("run_history").where('User', isEqualTo: uid).snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getDocIds(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: docIDs.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: runHistoryCards(documentiD: docIDs[index])
                );
              }));

          }),
      ),
    );
  }
}
// RunHistoryCards(distance: index.toString(), heartRate: index.toString(), hours: index.toString(), minutes: index.toString(), mydate: index.toString(), seconds: index.toString(), steps: index.toString(),);