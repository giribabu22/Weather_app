import 'package:flutter/material.dart';
import 'report.dart';

class InputPage extends StatefulWidget {
  InputPage({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Enter city name: ',
              ),
            ),
            TextButton(

              onPressed: () {
                print('controller.text: ${controller.text}');
                controller.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherReport(),
                  ),
                );
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}