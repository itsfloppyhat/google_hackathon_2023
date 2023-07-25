import 'package:flutter/material.dart';
import "package:google_hackathon_2023/pages/login_page.dart";
import "package:google_hackathon_2023/pages/register_page.dart";
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  // initially show login page
  bool showLoginPage = true;

  void showPage () {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage)
    {
      return LoginPage(showSignUpPage: showPage);
    }
    else{
      return RegisterPage(showLoginPage: showPage,);
    }
  }
}