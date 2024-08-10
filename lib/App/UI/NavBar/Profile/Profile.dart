
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Resources/Color.dart';
import '../../../Resources/Components/AppBar.dart';

class Profile extends StatelessWidget {
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
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            SizedBox(height: 20),

            // Name and Email
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: FColor.primaryColor1,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'john.doe@example.com',
              style: TextStyle(
                fontSize: 18,
                color: FColor.GreyBrown,
              ),
            ),
            SizedBox(height: 30),

            // User Details
            _buildInfoRow(Icons.calendar_today, 'Joining Date', '10 May 2022'),
            _buildInfoRow(Icons.person, 'Role', 'Employee'),
            _buildInfoRow(Icons.check_circle, 'Attendance', '95%'),
            SizedBox(height: 30),

            // Completed Projects Table
            Text(
              'Completed Projects',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: FColor.primaryColor1),
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: FColor.primaryColor1),
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: FColor.primaryColor1),
            ),
            SizedBox(height: 10),
            _buildDocumentRow(Icons.description, 'CV'),
            _buildDocumentRow(Icons.school, 'Result Card'),
            _buildDocumentRow(Icons.verified, 'Experience Letter'),
            SizedBox(height: 30),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FColor.primaryColor1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text('Edit Profile'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FColor.primaryColor1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text('View Documents'),
                ),
              ],
            ),
            SizedBox(height: 250,)
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

  Widget _buildProjectsTable(
      BuildContext context, List<String> projects, IconData icon, Color iconColor) {
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

  Widget _buildDocumentRow(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: FColor.primaryColor1),
      title: Text(label),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Handle document view or download
      },
    );
  }
}

