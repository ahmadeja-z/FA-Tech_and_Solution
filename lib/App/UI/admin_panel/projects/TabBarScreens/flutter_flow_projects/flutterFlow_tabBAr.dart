import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../Resources/Color.dart';
import 'flutterFlow_projects/onGoing_flutterFlow_projects.dart';
import 'flutterFlow_projects/pending_flutterFlow_projects.dart';

class FlutterFlowTabBar extends StatefulWidget {
  const FlutterFlowTabBar({super.key});
  @override
  _FlutterFlowTabBarState createState() => _FlutterFlowTabBarState();
}

class _FlutterFlowTabBarState extends State<FlutterFlowTabBar>
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
                OnGoingFlutterFlowProjects(),
                PendingFlutterFlowProjects(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
