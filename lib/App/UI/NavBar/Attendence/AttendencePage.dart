import 'package:fasolution/App/Resources/Components/AppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fasolution/App/Resources/Color.dart';

import 'MarkAttendencePage.dart';

class AttendancePage extends StatelessWidget {

  final List<Map<String, String>> previousAttendances = [
    {'date': '01 August 2024', 'status': 'Present'},
    {'date': '31 July 2024', 'status': 'Absent'},
    {'date': '30 July 2024', 'status': 'Present'},

  ];

  void _navigateToMarkAttendance(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MarkAttendancePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _navigateToMarkAttendance(context),
              child: Text('Mark Today\'s Attendance'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: FColor.primaryColor1,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: previousAttendances.length,
                itemBuilder: (context, index) {
                  final attendance = previousAttendances[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        attendance['date']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: FColor.primaryColor1,
                        ),
                      ),
                      subtitle: Text(
                        'Status: ${attendance['status']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: FColor.GreyBrown,
                        ),
                      ),
                      trailing: Icon(CupertinoIcons.smiley),
                    ),
                  );
                },
              ),
            ),


          ],
        ),
      ),
    );
  }
}
