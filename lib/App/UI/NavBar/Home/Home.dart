import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Resources/Color.dart';
import '../../../Resources/Components/AppBar.dart';
import '../../../Resources/Components/PersonCard.dart';

class PeoplePage extends StatelessWidget {
  final List<Map<String, String>> people = [
    {
      'name': 'John Doe',
      'profilePictureUrl': 'https://via.placeholder.com/80',
      'joiningDate': '01 January 2020',
      'career': 'Software Developer',
      'email': 'john.doe@example.com', // Email
      'role': 'Team Lead',              // Role
    },
    {
      'name': 'Jane Smith',
      'profilePictureUrl': 'https://via.placeholder.com/80',
      'joiningDate': '15 March 2021',
      'career': 'UI/UX Designer',
      'email': 'jane.smith@example.com', // Email
      'role': 'Senior Designer',         // Role
    },
    // Add more people here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                final person = people[index];
                return PersonCard(
                  name: person['name']!,
                  profilePictureUrl: person['profilePictureUrl']!,
                  joiningDate: person['joiningDate']!,
                  career: person['career']!,
                  email: person['email']!,   // Pass email
                  role: person['role']!,     // Pass role
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
