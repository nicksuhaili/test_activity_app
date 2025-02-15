import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  String _activity = "Tap below to discover an activity!";
  String _price = "";
  final List<Map<String, String>> _history = [];

  List<String> activityTypes = [
    "education",
    "recreational",
    "social",
    "diy",
    "charity",
  ];
  String? _selectedType;

  void _fetchActivity() async {
    try {
      final data = await _apiService.fetchRandomActivity(type: _selectedType);
      setState(() {
        _activity = data['activity'];
        _price = "Price: \$${data['price']}";
        _history.insert(0, {"activity": _activity, "price": _price});
        if (_history.length > 50) _history.removeLast();
      });

      _saveData();
    } catch (e) {
      setState(() {
        _activity = "Oops! Something went wrong.";
        _price = "";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Activity App"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _activity,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            Text(_price, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 30),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  hint: const Text("Select Activity Type"),
                  value: _selectedType,
                  items:
                      activityTypes.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType = newValue;
                    });
                  },
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _fetchActivity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Next", style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 16),

                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryScreen(history: _history),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Colors.teal, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "View History",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedType', _selectedType ?? '');
    prefs.setString('history', json.encode(_history));
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedType = prefs.getString('selectedType') ?? '';
      String? historyData = prefs.getString('history');
      if (historyData != null) {
        _history.clear();
        _history.addAll(
          List<Map<String, String>>.from(json.decode(historyData)),
        );
      }
    });
  }
}
