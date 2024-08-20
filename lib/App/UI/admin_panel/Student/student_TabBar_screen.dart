import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/UI/admin_panel/Student/TabBar/flutterFlow_Student_screen.dart';
import 'package:fasolution/App/UI/admin_panel/Student/TabBar/flutter_Student_screen.dart';
import 'package:fasolution/App/UI/admin_panel/Student/TabBar/web_Student_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Resources/Color.dart';
class StudentTabBar extends StatefulWidget {
  const StudentTabBar({super.key});
  @override
  _StudentTabBarState createState() => _StudentTabBarState();
}

class _StudentTabBarState extends State<StudentTabBar>
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
      appBar: CustomizableAppBar(title: 'Student',
        leadingIcon:Icon(CupertinoIcons.back),
        onLeadingPressed: (){Navigator.pop(context);},)
      ,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,

                  blurRadius: 3.0,
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontFamily: 'Lato'),
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                color: FColor.primaryColor1,
                borderRadius: BorderRadius.circular(10.0),

              ),
              dividerHeight: 0 ,
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
              children: [
                WebStudent(),
                FlutterFlowStudent(),
                FlutterStudent(),

              ],
            ),
          ),
        ],
      ),
    );
  }
}