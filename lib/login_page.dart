import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  'Hello Again!',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 40, color: Color.fromARGB(255, 172, 237, 81)),
                ),
                SizedBox(height: 10),
                Text(
                  "Let's run it back",
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username',
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
                        onPressed: () {},
                        child: const Text("Sign In"),
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
                      'Not a member?',
                      style:
                          TextStyle(color: Color.fromARGB(255, 172, 237, 81)),
                    ),
                    Text(
                      ' Register now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 172, 237, 81)),
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
