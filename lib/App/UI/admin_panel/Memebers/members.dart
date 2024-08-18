import 'package:flutter/material.dart';
import '../../../Resources/Color.dart';

class CareerAndRolePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: FColor.primaryColor1,
          title: const Text('Career & Role'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Career'),
              Tab(text: 'Role'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CareerTab(),
            RoleTab(),
          ],
        ),
      ),
    );
  }
}

class CareerTab extends StatelessWidget {
  const CareerTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'This is the Career tab.',
          style: TextStyle(fontSize: 18, color: FColor.primaryColor1),
        ),
      ),
    );
  }
}

class RoleTab extends StatelessWidget {
  const RoleTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'This is the Role tab.',
          style: TextStyle(fontSize: 18, color: FColor.primaryColor1),
        ),
      ),
    );
  }
}
