import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final bool isPassword;
  final String text;
   
  const MyWidget({super.key, required this.isPassword, required this.text});
  
  @override
  //Color boxColor = Color.fromARGB(255, 172, 237, 81);
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(244, 244, 244, 0.561),
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                        style: TextStyle(
                          color: Color.fromARGB(255, 172, 237, 81),
        ),
      ),
    );
  }
}
