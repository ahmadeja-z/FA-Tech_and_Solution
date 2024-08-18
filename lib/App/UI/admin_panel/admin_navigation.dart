import 'package:fasolution/App/UI/NavBar/Announsments/Announsments.dart';
import 'package:fasolution/App/UI/admin_panel/Announcements/announcementsPage.dart';
import 'package:flutter/material.dart';
import '../../Resources/Color.dart';

class AdminPanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        backgroundColor: FColor.primaryColor1, // Use your primary color here
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // 2 items per row
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildGridTile(
              title: 'Employees',
              icon: Icons.person,
              onTap: () {
                // Navigate to Employees screen
              },
            ),
            _buildGridTile(
              title: 'Students',
              icon: Icons.school,
              onTap: () {
                // Navigate to Students screen
              },
            ),
            _buildGridTile(
              title: 'Internships',
              icon: Icons.work,
              onTap: () {
                // Navigate to Internships screen
              },
            ),
            _buildGridTile(
              title: 'Announcements',
              icon: Icons.announcement,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => adminAnnouncementsPage(),));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridTile({required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48.0, color: FColor.primaryColor1), // Use your primary color here
            SizedBox(height: 16.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
