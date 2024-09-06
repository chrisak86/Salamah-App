import 'package:flutter/material.dart';

class PoliceStationView extends StatelessWidget {
  final List<Map<String, String>> policeStations = [
    {'name': 'Medicare', 'address': 'New York Street #201', 'status': 'Active'},
    {'name': 'Medicare', 'address': 'New York Street #202', 'status': 'Inactive'},
    {'name': 'Medicare', 'address': 'New York Street #203', 'status': 'Active'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Police Stations'),
      ),
      body: ListView.builder(
        itemCount: policeStations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(policeStations[index]['name']!),
            subtitle: Text(policeStations[index]['address']!),
            trailing: Chip(
              label: Text(policeStations[index]['status']!),
              backgroundColor: policeStations[index]['status'] == 'Active'
                  ? Colors.green
                  : Colors.red,
            ),
          );
        },
      ),
    );
  }
}