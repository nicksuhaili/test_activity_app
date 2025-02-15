import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  String _activity = "Press Next to get an activity!";
  String _price = "";

  void _fetchActivity() async {
    try {
      final data = await _apiService.fetchRandomActivity();
      setState(() {
        _activity = data['activity'];
        _price = "Price: \$${data['price']}";
      });
    } catch (e) {
      setState(() {
        _activity = "Error fetching activity";
        _price = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Activity App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_activity, style: const TextStyle(fontSize: 18), textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Text(_price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchActivity,
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}