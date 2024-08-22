import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/UI/admin_panel/CompletedProjects/CompleteProjects/completed_flutterFlow_projects.dart';
import 'package:fasolution/App/UI/admin_panel/CompletedProjects/CompleteProjects/completed_flutter_projects.dart';
import 'package:fasolution/App/UI/admin_panel/CompletedProjects/CompleteProjects/completed_web_projects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Resources/Color.dart';

class CompletedProjectsTabBar extends StatefulWidget {
  const CompletedProjectsTabBar({super.key});
  @override
  _CompletedProjectsTabBarState createState() => _CompletedProjectsTabBarState();
}

class _CompletedProjectsTabBarState extends State<CompletedProjectsTabBar>
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
      appBar: CustomizableAppBar(
        title: 'Completed Projects',
        leadingIcon: const Icon(CupertinoIcons.back),
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              labelStyle: const TextStyle(fontFamily: 'Lato'),
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                color: FColor.primaryColor1,
                borderRadius: BorderRadius.circular(10.0),
              ),
              dividerHeight: 0,
              isScrollable: true,
              tabs: const [
                Tab(text: ' Web Development '),
                Tab(text: " Flutter Flow "),
                Tab(text: " Flutter "),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                CompletedWebProjects(),
                CompletedFlutterFlowProjects(),
                CompletedFlutterProjects()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
