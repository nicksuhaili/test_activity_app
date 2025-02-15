import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  final List<Map<String, String>> history;

  const HistoryScreen({super.key, required this.history});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  late List<Map<String, String>> _history;

  @override
  void initState() {
    super.initState();
    _history = widget.history;
    _loadHistory();
  }

  void _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    String? historyData = prefs.getString('history');
    if (historyData != null) {
      setState(() {
        _history = List<Map<String, String>>.from(json.decode(historyData));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Activity History"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body:
          _history.isEmpty
              ? const Center(
                child: Text(
                  "No history yet!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              )
              : ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        _history[index]['activity']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(_history[index]['price']!),
                      leading: const Icon(
                        Icons.check_circle,
                        color: Colors.teal,
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
