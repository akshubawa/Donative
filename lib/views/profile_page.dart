import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donative/app/user_auth/button_widget.dart';
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
                            "https://media.licdn.com/dms/image/D4D03AQFmS789TcUDOg/profile-displayphoto-shrink_800_800/0/1675710993462?e=1711584000&v=beta&t=KUbap9iQ0hyC47A5z8C_oWEKK2j62T5nK5dfMTF09EQ"),
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
                  ButtonWidget(onTap: () {}, buttonText: "Update Profile"),
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
