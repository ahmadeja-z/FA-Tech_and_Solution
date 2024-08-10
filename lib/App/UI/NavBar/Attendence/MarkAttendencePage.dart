import 'package:fasolution/App/Resources/Components/AppBar.dart';
import 'package:fasolution/App/Resources/Components/GradientText.dart';
import 'package:fasolution/App/Utils/ShowMessage/StatusBars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fasolution/App/Resources/Color.dart';

import '../../../Resources/Components/AppBar2.dart';

class MarkAttendancePage extends StatefulWidget {
  @override
  _MarkAttendancePageState createState() => _MarkAttendancePageState();
}

class _MarkAttendancePageState extends State<MarkAttendancePage> {
  bool _isCheckedIn = false;

  void _markAttendance() {
    setState(() {
      _isCheckedIn = true;
    });

CustomSnackbar.show(context: context, title: 'Attendence Marked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizableAppBar(title: 'Mark Attendance',leadingIcon: Icon(CupertinoIcons.back),
      onLeadingPressed: (){Navigator.pop(context);},),
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
                        _isCheckedIn ? Icons.check_circle : Icons.hourglass_empty,
                        size: 100,
                        color: _isCheckedIn ? FColor.primaryColor1 : FColor.GreyBrown,
                      ),
                      SizedBox(height: 20),
                   GradientText(text:  _isCheckedIn
                       ? 'Attendance Confirmed'
                       : 'Mark Your Attendance',
                       style: TextStyle(
                         fontSize: 24,
                         fontWeight: FontWeight.bold,
                         fontFamily: 'Lato',
                         color: FColor.primaryColor1,
                       ), gradient: LinearGradient(colors: FColor.PrimaryGradient)),
                      SizedBox(height: 20),
                      if (!_isCheckedIn) ...[
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
                          decoration: InputDecoration(
                            labelText: 'Enter your email',

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _markAttendance,
                          child: Text('Mark Attendance',style: TextStyle(fontFamily: 'Lato'),),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: FColor.primaryColor1,
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
