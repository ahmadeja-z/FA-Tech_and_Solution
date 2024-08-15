import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fasolution/App/Resources/Color.dart';
import 'package:fasolution/App/Utils/ShowMessage/StatusBars.dart';

class MarkAttendancePage extends StatefulWidget {
  final UserModel userModel; // Pass the user's email to mark attendance

  MarkAttendancePage({required this.userModel});

  @override
  _MarkAttendancePageState createState() => _MarkAttendancePageState();
}

class _MarkAttendancePageState extends State<MarkAttendancePage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isCheckedIn = false;
  bool _emailValid = true;
  bool _alreadyCheckedInToday = false;
  bool _isAbsent = false;
  double _attendancePercentage = 0.0;
  final DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _calculateAttendancePercentage();
    _checkIfAlreadyCheckedInToday();
  }

  Future<void> _checkIfAlreadyCheckedInToday() async {
    final today = DateTime.now().toLocal().toIso8601String().split('T').first;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('attendance')
          .doc(widget.userModel.email)
          .collection('dates')
          .doc(today)
          .get();

      if (doc.exists) {
        setState(() {
          _isCheckedIn = true;
          _alreadyCheckedInToday = true;
        });
      } else {
        setState(() {
          _isAbsent = true;
        });
      }
    } catch (e) {
      print('Error checking attendance: $e');
      // Handle errors appropriately
    }
  }

  Future<void> _markAttendance() async {
    final enteredEmail = _emailController.text.trim();
    final today = DateTime.now().toLocal().toIso8601String().split('T').first;

    if (enteredEmail != widget.userModel.email) {
      setState(() {
        _emailValid = false;
      });
      return;
    }

    if (_alreadyCheckedInToday) {
      CustomSnackbar.show(context: context, title: 'Attendance already marked for today.');
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('attendance')
          .doc(widget.userModel.email)
          .collection('dates')
          .doc(today)
          .set({
        'date': today,
        'status': 'Present',
      });

      setState(() {
        _isCheckedIn = true;
        _alreadyCheckedInToday = true;
        _isAbsent = false;
      });

      CustomSnackbar.show(context: context, title: 'Attendance marked successfully.');
    } catch (e) {
      print('Error marking attendance: $e');
      CustomSnackbar.show(context: context, title: 'Error marking attendance.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mark Attendance'),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 10,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isCheckedIn
                            ? Icons.check_circle
                            : _isAbsent
                            ? Icons.cancel
                            : Icons.hourglass_empty,
                        size: 100,
                        color: _isCheckedIn
                            ? FColor.primaryColor1
                            : _isAbsent
                            ? Colors.red
                            : FColor.GreyBrown,
                      ),
                      SizedBox(height: 20),
                      Text(
                        _isCheckedIn
                            ? 'Attendance Confirmed'
                            : _isAbsent
                            ? 'You are marked as Absent'
                            : 'Mark Your Attendance',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                          color: FColor.primaryColor1,
                        ),
                      ),
                      SizedBox(height: 20),
                      if (!_isCheckedIn && !_isAbsent) ...[
                        Text(
                          'Please confirm your email to mark your attendance.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            color: FColor.GreyBrown,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Enter your email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            errorText: _emailValid ? null : 'Email does not match.',
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _markAttendance,
                          child: Text('Mark Attendance', style: TextStyle(fontFamily: 'Lato')),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: FColor.primaryColor1,
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _calculateAttendancePercentage() async {
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
    final totalDays = endOfMonth.day;

    try {
      final attendanceCollection = FirebaseFirestore.instance
          .collection('attendance')
          .doc(widget.userModel.email)
          .collection('dates');

      final querySnapshot = await attendanceCollection
          .where('date', isGreaterThanOrEqualTo: startOfMonth.toIso8601String())
          .where('date', isLessThanOrEqualTo: endOfMonth.toIso8601String())
          .get();

      final totalPresentDays = querySnapshot.docs
          .where((doc) => doc['status'] == 'Present')
          .length;

      setState(() {
        _attendancePercentage = (totalPresentDays / totalDays) * 100;
      });

      widget.userModel.attendance='${_attendancePercentage}%';
      await FirebaseFirestore.instance.collection('users').doc(widget.userModel.userId).set(widget.userModel.toMap());
    } catch (e) {
      print('Error calculating attendance percentage: $e');
      // Handle errors appropriately
    }
  }
}
