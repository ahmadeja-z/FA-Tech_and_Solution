import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../Model/Model/UserModel.dart';
import 'Projects/complete_project.dart';
import 'Projects/onGoing_project.dart';
import 'Projects/pending_project.dart';
import '../../../Resources/Color.dart';
import '../../../Resources/Components/AppBar2.dart';

class UserProjectsTabBar extends StatefulWidget {
  final String userId;
  final UserModel userModel;

  UserProjectsTabBar({Key? key, required this.userId, required this.userModel})
      : super(key: key);

  @override
  State<UserProjectsTabBar> createState() => _UserProjectsTabBarState();
}

class _UserProjectsTabBarState extends State<UserProjectsTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .snapshots(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (userSnapshot.hasError) {
            return Center(child: Text('Error: ${userSnapshot.error}'));
          } else if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
            return Center(child: Text('No user data found.'));
          } else {
            UserModel userModel = UserModel.fromMap(
                userSnapshot.data!.data() as Map<String, dynamic>);
            final projectIds = userModel.ongoingProjectIds ?? [];

            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16.0),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: FColor.primaryColor1,
                    labelStyle: const TextStyle(
                        fontFamily: 'Lato', fontWeight: FontWeight.bold),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor:
                        Colors.transparent, // Remove the indicator color
                    indicator: BoxDecoration(
                      color: Colors.transparent, // Remove background effect
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: FColor.primaryColor1,
                          width: 2.0), // Custom border effect
                    ),
                    dividerHeight: 0,
                    isScrollable: true,
                    tabs: const [
                      Tab(text: '  Ongoing Projects  '),
                      Tab(text: '  Pending Projects  '),
                      Tab(text: '  Completed Projects  '),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      OngoingProjectsScreen(
                          projectIds: projectIds, userModel: widget.userModel),
                      PendingProjectsPage(
                          userId: widget.userModel.userId.toString()),
                      CompletedProjectsScreen(
                          projectIds: projectIds, userModel: widget.userModel),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
