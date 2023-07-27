import 'package:flutter/material.dart';

class HealthCard extends StatefulWidget {
  final String title;
  final String displayData;
  final String image;
  final Color color;
  const HealthCard({super.key, required this.title, required this.displayData, required this.color, required this.image});

  @override
  State<HealthCard> createState() => _HealthCardState();
}

class _HealthCardState extends State<HealthCard> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(widget.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
              Image.asset(widget.image, width: 70),
          Text(widget.displayData),
        ],
      ),
    );
}
}