import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donative/app/features/my_donation_card.dart';
import 'package:donative/app/models/payments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDonationsView extends StatelessWidget {
  final Payment? payment;
  const MyDonationsView({
    Key? key,
    this.payment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text(
          "My Donations",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 20, 8, 5),
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: users.doc(currentUserId).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return Text("Document does not exist");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Text(
                    "YOUR TOTAL DONATION: ₹${data['donatedAmount'] ?? '0'}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }

                return Text("loading");
              },
            ),
            const SizedBox(
              height: 8,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('payments')
                  .where('userId', isEqualTo: currentUserId)
                  .snapshots(),
              builder: (context, snapshot) {
                // print("SNAPSHOT CONNECTION STATE: $snapshot.connectionState");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child:
                        Text('Error loading your donations: ${snapshot.error}'),
                  );
                } else if (snapshot.data == null ||
                    snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('You have no Donations yet!'),
                  );
                } else {
                  final payments = snapshot.data!.docs
                      .map((doc) =>
                          Payment.fromJson(doc.data() as Map<String, dynamic>))
                      .toList();
                  return Flexible(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final payment = payments[index];
                        return InkWell(
                          onTap: () {},
                          child: MyDonationCard(
                            payment: payment,
                          ),
                        );
                      },
                      itemCount: payments.length,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
