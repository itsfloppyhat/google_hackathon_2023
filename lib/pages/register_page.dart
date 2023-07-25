import 'package:flutter/material.dart';
//import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // title
            Text(
              "Register Now!",
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 172, 237, 81),
              ),
            ),

            SizedBox(
              height: 80,
            ),
            // email
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(244, 244, 244, 0.561),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal : 8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //password
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(244, 244, 244, 0.561),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal : 8.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
            ),
            // register now button
            GestureDetector(
              onTap: () {
                registerUser();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 172, 237, 81),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                      child: Text(
                    "Register Now",
                  )),
                ),
              ),
            ),

            SizedBox(
                  height: 10,
                ),
            // already a member? sign in 
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style:
                          TextStyle(color: Color.fromARGB(255, 172, 237, 81)),
                    ),
                    GestureDetector(
                      // go to register page
                      onTap: widget.showLoginPage,                       
                        child: Text(
                          ' Log in now!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 172, 237, 81)),
                        ),
                      
                    ),
                  ],
                )
          ],
        ),
      )),
    );
  }
}
