import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fasolution/App/Resources/Color.dart';
import '../../../Model/Model/attendence_model.dart';
import 'MarkAttendencePage.dart';

class AttendancePage extends StatefulWidget {
  final UserModel userModel; // Pass the user's email to fetch attendance records

  AttendancePage({required this.userModel});

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late Future<AttendanceModel> _attendanceFuture;

  @override
  void initState() {
    super.initState();
    _attendanceFuture = _fetchAttendanceData();
  }

  Future<AttendanceModel> _fetchAttendanceData() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('attendance')
          .doc(widget.userModel.email)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        return AttendanceModel.fromMap(data);
      } else {
        throw Exception('No attendance data found for this user.');
      }
    } catch (e) {
      print('Error fetching attendance data: $e');
      throw e; // Re-throw the error to be caught by the FutureBuilder
    }
  }

  void _navigateToMarkAttendance(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MarkAttendancePage(userModel: widget.userModel)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => _navigateToMarkAttendance(context),
              child: Text('Mark Today\'s Attendance'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: FColor.primaryColor1,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<AttendanceModel>(
              future: _attendanceFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No data available.'));
                }

                final attendanceModel = snapshot.data!;
                final totalWorkingDays = DateTime.now().day; // Assuming working days are equal to the current day of the month
                final totalPresent = int.parse(attendanceModel.present ?? '0');
                final totalAbsent = int.parse(attendanceModel.absent ?? '0');
                final totalLeaves = int.parse(attendanceModel.leaves ?? '0');

                final attendancePercentage = totalWorkingDays > 0
                    ? (totalPresent / totalWorkingDays) * 100
                    : 0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Attendance Percentage: ${attendancePercentage.toStringAsFixed(2)}%',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: FColor.primaryColor1),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Total Working Days: $totalWorkingDays',
                      style: TextStyle(fontSize: 16, color: FColor.GreyBrown),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Total Present: $totalPresent',
                      style: TextStyle(fontSize: 16, color: FColor.GreyBrown),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Total Absent: $totalAbsent',
                      style: TextStyle(fontSize: 16, color: FColor.GreyBrown),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Total Leaves: $totalLeaves',
                      style: TextStyle(fontSize: 16, color: FColor.GreyBrown),
                    ),
                    SizedBox(height: 20),
                    // Display a list of attendance records (if needed)
                    // This part can be updated based on how you want to fetch and display historical data.
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
