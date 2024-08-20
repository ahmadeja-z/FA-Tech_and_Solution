import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/UI/admin_panel/projects/TabBarScreens/flutterFlow_screens.dart';
import 'package:fasolution/App/UI/admin_panel/projects/TabBarScreens/flutter_projects.dart';
import 'package:fasolution/App/UI/admin_panel/projects/TabBarScreens/webdevelopment_screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Resources/Color.dart';

class ProjectsTabBar extends StatefulWidget {
  const ProjectsTabBar({super.key});
  @override
  _ProjectsTabBarState createState() => _ProjectsTabBarState();
}

class _ProjectsTabBarState extends State<ProjectsTabBar>
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
        title: 'Projects',
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
                WebDevelopmentProjects(),
                FlutterFlowProjects(),
                FlutterProjects()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
