import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fasolution/App/Resources/Color.dart';
import 'package:fasolution/App/Utils/ShowMessage/StatusBars.dart';
import '../../../Model/Model/attendence_model.dart';

class MarkAttendancePage extends StatefulWidget {
  final UserModel userModel;

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
  AttendanceModel? _attendanceModel;

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    try {
      final attendanceDoc = await FirebaseFirestore.instance
          .collection('attendance')
          .doc(widget.userModel.email)
          .get();

      if (attendanceDoc.exists) {
        setState(() {
          _attendanceModel = AttendanceModel.fromMap(attendanceDoc.data()!);
        });
      } else {
        _attendanceModel = AttendanceModel(
          widget.userModel.userId,
          "0",
          "0",
          "0",
          "0",
          "10", // Assuming 10 leaves initially
        );
        await FirebaseFirestore.instance
            .collection('attendance')
            .doc(widget.userModel.email)
            .set(_attendanceModel!.toMap());
      }
      _checkIfAlreadyCheckedInToday();
    } catch (e) {
      print('Error fetching attendance data: $e');
      CustomSnackbar.show(context: context, title: 'Error fetching attendance data.');
    }
  }

  Future<void> _checkIfAlreadyCheckedInToday() async {
    final today = DateTime.now().toLocal().toIso8601String().split('T').first;
    final now = DateTime.now();

    try {
      // Check if it's a weekend
      if (now.weekday == DateTime.friday) {
        setState(() {
          _isAbsent = true;
          _alreadyCheckedInToday = false;
        });
        CustomSnackbar.show(context: context, title: 'Attendance is not allowed on Sundays.');
        return;
      }

      // Check if current time is within the allowed attendance hours
      if (now.hour < 1 || now.hour > 23) {
        setState(() {
          _isAbsent = true;
          _alreadyCheckedInToday = false;
        });
        CustomSnackbar.show(context: context, title: 'Attendance can only be marked between 8 AM and 9 PM.');
        return;
      }

      final doc = await FirebaseFirestore.instance
          .collection('attendance')
          .doc(widget.userModel.email)
          .collection('dates')
          .doc(today)
          .get();

      setState(() {
        if (doc.exists) {
          _isCheckedIn = true;
          _alreadyCheckedInToday = true;
          _isAbsent = false;
        } else {
          _isCheckedIn = false;
          _alreadyCheckedInToday = false;
          _isAbsent = false;
        }
      });
    } catch (e) {
      print('Error checking attendance: $e');
      CustomSnackbar.show(context: context, title: 'Error checking attendance.');
    }
  }

  Future<void> _markAttendance() async {
    final enteredEmail = _emailController.text.trim();
    final today = DateTime.now().toLocal().toIso8601String().split('T').first;
    final now = DateTime.now();

    // Check if it's a weekend
    if (now.weekday == DateTime.sunday) {
      setState(() {
        _isAbsent = true;
        _emailValid = true;
      });
      CustomSnackbar.show(context: context, title: 'Attendance is not allowed on Sundays.');
      return;
    }

    // Check if current time is within the allowed attendance hours
    if (now.hour < 8 || now.hour > 21) {
      setState(() {
        _isAbsent = true;
        _emailValid = true;
      });
      CustomSnackbar.show(context: context, title: 'Attendance can only be marked between 8 AM and 9 PM.');
      return;
    }

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
        _attendanceModel!.totalClasses = (int.parse(_attendanceModel!.totalClasses!) + 1).toString();
        _attendanceModel!.present = (int.parse(_attendanceModel!.present!) + 1).toString();
        _isCheckedIn = true;
        _alreadyCheckedInToday = true;
        _isAbsent = false;
      });

      await FirebaseFirestore.instance
          .collection('attendance')
          .doc(widget.userModel.email)
          .update(_attendanceModel!.toMap());

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
}
