import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donative/app/features/build_funding_card.dart';
import 'package:donative/app/models/fundraiser.dart';
import 'package:donative/views/fundraiser_detail_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyFundraiserView extends StatelessWidget {
  const MyFundraiserView({super.key});

  @override
  Widget build(BuildContext context) {
    String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text(
          "My Fundraisers",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('fundraisers')
                  .where('uid', isEqualTo: currentUserId)
                  .snapshots(),
              builder: (context, snapshot) {
                // print("SNAPSHOT CONNECTION STATE: $snapshot.connectionState");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error loading fundraisers: ${snapshot.error}'),
                  );
                } else if (snapshot.data == null) {
                  return const Center(
                    child: Text('You have no fundraisers yet!'),
                  );
                } else {
                  final fundraisers = snapshot.data!.docs
                      .map((doc) => Fundraiser.fromJson(
                          doc.data() as Map<String, dynamic>))
                      .toList();
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final fundraiser = fundraisers[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FundraiserDetailView(
                                  fundraiser: fundraiser,
                                ),
                              ),
                            );
                          },
                          child: BuildFundingCard(fundraiser: fundraiser, showStatus: true),
                        );
                      },
                      itemCount: fundraisers.length,
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
