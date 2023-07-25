import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RunDesignPage extends StatefulWidget {
  const RunDesignPage({Key? key}) : super(key: key);

  @override
  State<RunDesignPage> createState() => _RunDesignState();
}

class _RunDesignState extends State<RunDesignPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed in as ${user.email!}'),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.deepPurple[200],
              child: Text('sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
