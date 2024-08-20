import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:fasolution/App/UI/NavBar/Home/detail_person_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Resources/Color.dart';
import '../../../Resources/Components/AppBar.dart';
import '../../../Resources/Components/PersonCard.dart';

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search People...',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: FColor.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.trim().toLowerCase();
                  });
                },
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection('users').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text('No users found'),
                      );
                    }
                    List<UserModel> users = snapshot.data!.docs.map((doc) {
                      return UserModel.fromMap(
                          doc.data() as Map<String, dynamic>);
                    }).toList();

                    // Filter users based on search query
                    List<UserModel> filteredUsers = users.where((user) {
                      return user.name!.toLowerCase().contains(searchQuery) ||
                          user.email!.toLowerCase().contains(searchQuery) ||
                          user.role!.toLowerCase().contains(searchQuery);
                    }).toList();

                    return ListView.builder(
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                          UserModel user = filteredUsers[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailProfileInfo(
                                      name: user.name.toString(),
                                      profileImage:
                                          user.profilePictureUrl.toString(),
                                      role: user.role.toString(),
                                      surName: user.surName.toString(),
                                      carrier: user.carrier.toString(),
                                      attendance: user.attendance.toString(),
                                      email: user.email.toString(),
                                      joiningDate: user.joiningDate.toString(),
                                    ),
                                  ));
                            },
                            child: PersonCard(
                                name: user.name.toString(),
                                profilePictureUrl:
                                    user.profilePictureUrl.toString(),
                                joiningDate: user.joiningDate.toString(),
                                career: user.carrier.toString(),
                                email: user.email.toString(),
                                role: user.role.toString()),
                          );
                        });
                  }),
            ),

          ],
        ),
      ),
    );
  }
}
