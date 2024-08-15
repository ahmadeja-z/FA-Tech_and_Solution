import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fasolution/App/Resources/Color.dart';
import 'MarkAttendencePage.dart';

class AttendancePage extends StatefulWidget {
  final UserModel userModel; // Pass the user's email to fetch attendance records

  AttendancePage({required this.userModel});

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late Future<List<Map<String, String>>> _attendanceFuture;

  @override
  void initState() {
    super.initState();
    _attendanceFuture = _fetchAttendanceRecords();
  }

  Future<List<Map<String, String>>> _fetchAttendanceRecords() async {
    List<Map<String, String>> attendanceList = [];
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('attendance')
          .doc(widget.userModel.email)
          .collection('dates')
          .orderBy('date', descending: true) // Optional: Sort by date
          .get();

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        attendanceList.add({
          'date': data['date'] ?? 'Unknown Date',
          'status': data['status'] ?? 'Unknown Status',
        });
      }
    } catch (e) {
      print('Error fetching attendance records: $e');
      // Handle errors appropriately
    }
    return attendanceList;
  }

  void _navigateToMarkAttendance(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MarkAttendancePage( userModel: widget.userModel,)),
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
              child: FutureBuilder<List<Map<String, String>>>(
                future: _attendanceFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No attendance records found.'));
                  }

                  final attendanceList = snapshot.data!;
                  return ListView.builder(
                    itemCount: attendanceList.length,
                    itemBuilder: (context, index) {
                      final attendance = attendanceList[index];
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
