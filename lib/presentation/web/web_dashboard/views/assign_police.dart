import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/models/police_station.dart';
import 'package:salamah/presentation/web/web_dashboard/controllers/web_dashboard_controller.dart';

class AssignPoliceStationDialog extends StatefulWidget {
  final int policeId;
  final List policeStation;

  const AssignPoliceStationDialog({Key? key, required this.policeId,required this.policeStation}) : super(key: key);

  @override
  _AssignPoliceStationDialogState createState() => _AssignPoliceStationDialogState();
}

class _AssignPoliceStationDialogState extends State<AssignPoliceStationDialog> {
  List<int?> selectedStationIds = [];
  List<PoliceStation> policeStations = [];

  @override
  void initState() {
    super.initState();
    fetchPoliceStations();
  }

  fetchPoliceStations() {
    setState(() {
      policeStations = Get.find<WebDashboardController>().policeStations.value;
      if (widget.policeStation != null) {
        selectedStationIds.addAll(widget.policeStation.cast<int>());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Assign Police Stations'),
      content: policeStations.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: policeStations.map((station) {
            return CheckboxListTile(
              title: Text(station.police_station_name ?? ''),
              value: selectedStationIds.contains(station.id),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    setState(() {
                      selectedStationIds.add(station.id!);
                    });
                  } else {
                    setState(() {
                      selectedStationIds.remove(station.id!);
                    });
                  }
                });
              },
            );
                    }).toList(),
                  ),
          ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            _assignPoliceStations();
          },
          child: const Text('Assign'),
        ),
      ],
    );
  }

  void _assignPoliceStations() async {
    if (selectedStationIds.isNotEmpty) {
      Get.find<WebDashboardController>().assignPoliceStation(id: widget.policeId,policeStation:selectedStationIds );
      Navigator.of(context).pop();
    }
  }
}