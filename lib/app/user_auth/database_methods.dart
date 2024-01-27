import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  Future addUsers(Map<String, dynamic> usersInfoMap) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .set(usersInfoMap);
  }

  Future addFundraisers(Map<String, dynamic> fundraisersInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("fundraisers")
        .doc()
        .set(fundraisersInfoMap);
  }

  Future addPayments(Map<String, dynamic> paymentsInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("payments")
        .doc()
        .set(paymentsInfoMap);
  }
}
