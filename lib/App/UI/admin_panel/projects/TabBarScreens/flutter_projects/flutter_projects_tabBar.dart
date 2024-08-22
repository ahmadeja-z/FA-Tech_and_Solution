import 'package:fasolution/App/UI/admin_panel/projects/TabBarScreens/flutter_projects/flutter_projects/onGoing_flutter_projects.dart';
import 'package:fasolution/App/UI/admin_panel/projects/TabBarScreens/flutter_projects/flutter_projects/pending_flutter_projects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../Resources/Color.dart';

class FlutterTabBar extends StatefulWidget {
  const FlutterTabBar({super.key});
  @override
  _FlutterTabBarState createState() => _FlutterTabBarState();
}

class _FlutterTabBarState extends State<FlutterTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
              padding: EdgeInsets.symmetric(horizontal: 20),
              controller: _tabController,
              labelColor: Colors.white,
              labelStyle: const TextStyle(fontFamily: 'Lato'),
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                color: FColor.primaryColor1,
                borderRadius: BorderRadius.circular(10.0),
              ),
              dividerHeight: 0,
              automaticIndicatorColorAdjustment: true,

              tabs: const [
                Tab(text: ' On Going '),
                Tab(text: " Pending "),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                OnGoingFlutterProjects(),
                PendingFlutterProjects(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
