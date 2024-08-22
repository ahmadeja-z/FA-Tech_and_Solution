import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:flutter/material.dart';
import '../project_listWidget.dart';


class OngoingProjectsScreen extends StatelessWidget {
  final List<String> projectIds;
  final UserModel userModel;

  OngoingProjectsScreen({Key? key, required this.projectIds, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProjectListWidget(
      projectIds: projectIds,
      status: 'ongoing',
      userModel: userModel,
    );
  }
}
