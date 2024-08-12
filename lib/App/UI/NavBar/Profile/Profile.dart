import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:fasolution/App/UI/NavBar/Profile/FileViewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Resources/Color.dart';
import '../../../Resources/Components/AppBar.dart';
import '../../../Resources/Components/ProfileRow.dart';

class Profile extends StatefulWidget {
  Profile({super.key, required this.userModel, required this.FirebaseUser});
  final User FirebaseUser;
  final UserModel userModel;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  NetworkImage(widget.userModel.profilePictureUrl.toString()),
            ),
            SizedBox(height: 20),

            // Name and Email
            Text(
              '${widget.userModel.name.toString()} ${widget.userModel.surName.toString()}',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: FColor.primaryColor1,
              ),
            ),

            SizedBox(height: 10),
            Text(
              widget.userModel.email.toString(),
              style: TextStyle(
                fontSize: 18,
                color: FColor.GreyBrown,
              ),
            ),
            SizedBox(height: 30),

            // User Details
            _buildInfoRow(Icons.calendar_today, 'Joining Date',
                widget.userModel.joiningDate.toString()),
            _buildInfoRow(
                Icons.person, 'Role', widget.userModel.role.toString()),
            _buildInfoRow(Icons.check_circle, 'Attendance', '95%'),
            SizedBox(height: 30),

            // Completed Projects Table
            Text(
              'Completed Projects',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: FColor.primaryColor1),
            ),
            SizedBox(height: 10),
            _buildProjectsTable(
              context,
              ['Project Alpha', 'Project Beta'],
              Icons.check_circle_outline,
              FColor.primaryColor2,
            ),
            SizedBox(height: 30),

            // Ongoing Projects Table
            Text(
              'Ongoing Projects',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: FColor.primaryColor1),
            ),
            SizedBox(height: 10),
            _buildProjectsTable(
              context,
              ['Project Gamma', 'Project Delta'],
              Icons.timelapse,
              FColor.secondaryColor1,
            ),

            // Documents Section
            SizedBox(height: 30),
            Text(
              'Documents',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: FColor.primaryColor1),
            ),
            SizedBox(height: 10),
            DocumentRow(
              icon: Icons.description,
              label: 'CV',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FileViewer(
                        title: 'CV',
                          fileUrl: widget.userModel.cvUrl.toString()),
                    ));
              },
            ),
            DocumentRow(
              icon: Icons.school,
              label: 'Result',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FileViewer(
                        title: 'Result Card',
                          fileUrl: widget.userModel.resultCardUrl.toString()),
                    ));
              },
            ),
            DocumentRow(
              icon: Icons.verified,
              label: 'Experience Letter',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FileViewer(
                        title: 'Experience Letter',
                          fileUrl:
                              widget.userModel.experienceLetterUrl.toString()),
                    ));
              },
            ),

            SizedBox(height: 30),

            // Action Buttons
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: FColor.primaryColor1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Edit Profile',style: TextStyle(
                color: Colors.white
              ),),
            ),
            SizedBox(
              height: 250,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: FColor.primaryColor1),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 16, color: FColor.GreyBrown),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsTable(BuildContext context, List<String> projects,
      IconData icon, Color iconColor) {
    return Table(
      columnWidths: {
        0: FixedColumnWidth(50),
        1: FlexColumnWidth(),
      },
      border: TableBorder.all(color: FColor.GreyBrown),
      children: projects.map((project) {
        return TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon, color: iconColor),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                project,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
