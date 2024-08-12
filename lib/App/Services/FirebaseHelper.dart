import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Model/Model/UserModel.dart';

class FirebaseHelper {
  static Future<UserModel?> getInfo(String userId) async {
    UserModel? userModel;
    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (docSnap.data() != null) {
      return userModel =
          UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }
    return userModel;
  }
}
