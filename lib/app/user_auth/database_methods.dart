import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUsers(Map<String, dynamic> usersInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc()
        .set(usersInfoMap);
  }
}
