import 'package:flutter/material.dart';
import 'report.dart';

class InputPage extends StatelessWidget {
  InputPage({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App', style: TextStyle(fontFamily: AutofillHints.transactionAmount),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Get the very latest weather forecast, including hour-by-hour views, the 10-day outlook, temperature, humidity, precipitation for your area.'),
            const SizedBox(height: 5),
            const Text('Want a minute-by-minute forecast? MSN Weather tracks it all, from precipitation predictions to severe weather warnings, air quality updates, and even wildfire alerts'),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
                labelText: 'Enter city name: ',
                border: OutlineInputBorder(),
                fillColor: Colors.white24
              ),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isEmpty) {
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherReport(city: controller.text),
                  ),
                );
                // controller.clear();
              },
              child: Text('Search', style: TextStyle(fontSize: 20)),
            ),
            // )
          ],
        ),
      ),
    );
  }
}