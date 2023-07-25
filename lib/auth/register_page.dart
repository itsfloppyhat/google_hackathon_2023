import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _favoriteBandsController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    _favoriteBandsController.dispose();
    super.dispose();
  }

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
    addUserDetails(_displayNameController.text.trim(),
        _favoriteBandsController.text.trim(), _emailController.text.trim());
  }

  Future addUserDetails(
      String displayName, String favoriteBands, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'displayName': displayName,
      'favoriteBands': favoriteBands,
      'email': email
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 3, 3),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.flutter_dash,
                    size: 100, color: Color.fromARGB(255, 172, 237, 81)),
                Text(
                  'Hello There!',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 40, color: Color.fromARGB(255, 172, 237, 81)),
                ),
                SizedBox(height: 10),
                Text(
                  "Register Below and lets do this",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 172, 237, 81),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 244, 244, 0.561),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _displayNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'display name',
                      ),
                      style: TextStyle(
                        color: Color.fromARGB(255, 172, 237, 81),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 244, 244, 0.561),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _favoriteBandsController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'List your favorite bands!',
                      ),
                      style: TextStyle(
                        color: Color.fromARGB(255, 172, 237, 81),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 244, 244, 0.561),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                      style: TextStyle(
                        color: Color.fromARGB(255, 172, 237, 81),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 244, 244, 0.561),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                      style: TextStyle(
                        color: Color.fromARGB(255, 172, 237, 81),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor: Color.fromARGB(255, 172, 237, 81),
                            minimumSize: Size(double.infinity, 40)),
                        onPressed: () {
                          signUp();
                        },
                        child: const Text("Sign Up"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'I am a member!',
                      style:
                          TextStyle(color: Color.fromARGB(255, 172, 237, 81)),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        ' Login now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 172, 237, 81)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
