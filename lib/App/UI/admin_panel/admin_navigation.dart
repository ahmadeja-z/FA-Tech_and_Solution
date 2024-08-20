import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/UI/admin_panel/Announcements/announcementsPage.dart';
import 'package:fasolution/App/UI/admin_panel/Members/Emplyees/employees_TabBar_screen.dart';
import 'package:fasolution/App/UI/admin_panel/Members/Student/student_TabBar_screen.dart';
import 'package:fasolution/App/UI/admin_panel/projects/projects_tabBar_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Resources/Components/AdminPanelGrid.dart';
import 'Members/Internship/InternTabBar.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizableAppBar(title: 'Admin Panel'),
      body: Stack(alignment: Alignment.center,
        children: [
          Image.asset('assets/images/logo.png'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2, // 2 items per row
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: [
                buildGridTile(
                  title: 'Employees',
                  icon: CupertinoIcons.person,
                  onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const EmployeesTabBar(),));              },
                ),
                buildGridTile(
                  title: 'Students',
                  icon: Icons.school_outlined,
                  onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentTabBar(),)) ;             },
                ),
                buildGridTile(
                  title: 'Internships',
                  icon: Icons.work_outline,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InternTabBar(),
                        ));
                  },
                ),
                buildGridTile(
                  title: 'Announcements',
                  icon: Icons.announcement_outlined,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const adminAnnouncementsPage(),
                        ));
                  },
                ),
                buildGridTile(
                  title: 'Assign Project',
                  icon: Icons.assignment_ind_outlined,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectsTabBar(),
                        ));//
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}