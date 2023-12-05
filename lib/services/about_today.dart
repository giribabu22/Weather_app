
import 'package:flutter/material.dart';

class AboutToday extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const AboutToday({super.key, required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(icon, size: 50, color: Colors.white60,),
              const SizedBox(height: 10,),
              Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Text(value, style: const TextStyle(fontSize: 10),),
            ],
          ),
        ),
      ),
    );
  }
}