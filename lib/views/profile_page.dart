import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donative/app/profile_menu/update_profile.dart';
import 'package:donative/app/features/button_widget.dart';
import 'package:donative/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app/features/string_extension.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final Stream<DocumentSnapshot<Map<String, dynamic>>> userDataStream =
        FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .snapshots();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: userDataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Document does not exist'));
          }

          final userData = snapshot.data!.data()!;
          final String firstName =
              userData['firstName'].toString().capitalize();

          return Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                            "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=826&t=st=1705998704~exp=1705999304~hmac=94f210261e42c097bd53ad820556661109367d43ab094dc983e7d943a3b0693e"),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Hello, $firstName",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ButtonWidget(onTap: () {}, buttonText: "My Donations"),
                  const SizedBox(height: 15),
                  ButtonWidget(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UpdateProfile()),
                        );
                      },
                      buttonText: "Update Profile"),
                  const SizedBox(height: 15),
                  ButtonWidget(onTap: () {}, buttonText: "Settings"),
                  const SizedBox(height: 15),
                  ButtonWidget(onTap: () {}, buttonText: "Contact Us"),
                  const SizedBox(height: 15),
                  ButtonWidget(onTap: () {}, buttonText: "About Us"),
                  const SizedBox(height: 15),
                  ButtonWidget(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()),
                      );
                    },
                    buttonText: "Logout",
                    toastMessage: "Logged Out Successfully",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
