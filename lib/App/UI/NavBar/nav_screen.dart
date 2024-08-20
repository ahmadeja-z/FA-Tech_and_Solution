import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:fasolution/App/UI/Autentication/Login.dart';
import 'package:fasolution/App/UI/NavBar/Projects/project_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Resources/Color.dart';
import '../../Resources/Components/AppBar.dart';
import '../../Resources/Components/Drawer.dart';
import 'Attendence/AttendencePage.dart';
import 'Announsments/Announsments.dart';
import 'Home/people_info.dart';
import 'Profile/Profile.dart';

class NavigationScreen extends StatefulWidget {
  NavigationScreen({super.key, required this.userModel, required this.user});
  final UserModel userModel;
  final User user;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final List<Widget> _screens = [
      PeoplePage(),
      AttendancePage(userModel: widget.userModel,),
      AnnouncementsPage(),
      Profile(
        userModel: widget.userModel,
        FirebaseUser: widget.user,
      ),
    ];
  }

  List<Widget> get _screens => [
        PeoplePage(),
        AttendancePage(userModel: widget.userModel,),
        AnnouncementsPage(),
        Profile(userModel: widget.userModel, FirebaseUser: widget.user),
    UserProjectsScreen(userModel: widget.userModel,),
      ];
  final List<String> _titles = [
    'People',
    'Attendance',
    'Announcements',
    'Profile',
    'Projects'
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomizedAppBar(title: _titles[_currentIndex], UserId: widget.userModel.userId.toString(),), // Pass dynamic title
      backgroundColor:
          Colors.transparent, // Transparent background for the main content
      drawer: SideBox(
        // Add your drawer if needed
        profileName: widget.userModel.name.toString(),
        email: widget.userModel.email.toString(),
        profilePictureUrl: widget.userModel.profilePictureUrl.toString(),
        onTap: () {
          FirebaseAuth.instance.signOut();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
        },
      ),
      body: Stack(
        children: [
          _screens[_currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60, left: 30, right: 30),
              child: Container(
                height: 88,
                width: 366,
                decoration: BoxDecoration(
                  color: Colors.white, // Color of the Bottom Navigation Bar
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 4,
                      color: Colors.grey,
                      offset: Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(500),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BottomNavigationBar(
                    backgroundColor:
                        Colors.white, // Background of BottomNavigationBar
                    currentIndex: _currentIndex,
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    iconSize: 26,
                    selectedItemColor: FColor.primaryColor1,
                    unselectedItemColor: FColor.primaryColor2,
                    selectedLabelStyle: TextStyle(
                      fontFamily: 'Lato',
                    ),
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.home), label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.bookmark_add_outlined),
                          label: 'Attendance'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.announcement_outlined),
                          label: 'Announcement'),
                      BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.person), label: 'Profile'),
                 BottomNavigationBarItem(icon: Icon(Icons.work_outline),label: 'Projects')   ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
