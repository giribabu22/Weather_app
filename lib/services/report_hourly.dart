import 'package:flutter/material.dart';

class ReportToday extends StatelessWidget{
  final IconData icon;
  final String time;
  final String value;
  const ReportToday({super.key, required this.icon, required this.time, required this.value});
  @override
  Widget build(BuildContext context){
    return  SizedBox(
      child:Card(
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: SizedBox(
          width: 110,
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Icon(icon, size: 45, color: Colors.yellowAccent,),
                const SizedBox(height: 10,),
                Text(time, style: const TextStyle(fontSize: 10),),
                const SizedBox(height: 10,),
              ],
            ),
          ),
        )
      ),
    );
  }
}