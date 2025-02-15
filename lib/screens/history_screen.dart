import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<Map<String, String>> history;

  const HistoryScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Activity History"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: history.isEmpty
          ? const Center(
        child: Text(
          "No history yet!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black54),
        ),
      )
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(
                history[index]['activity']!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(history[index]['price']!),
              leading: const Icon(Icons.check_circle, color: Colors.teal),
            ),
          );
        },
      ),
    );
  }
}
