import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donative/app/features/build_funding_card.dart';
import 'package:donative/app/models/fundraiser.dart';
import 'package:donative/views/fundraiser_detail_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Future<List<Fundraiser>> loadFundraisers() async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text(
          "Donative",
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Handle search action
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('fundraisers').snapshots(),  
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
                    child: Text('No fundraisers available'),
                  );
                } else {
                  final fundraisers = snapshot.data!.docs.map((doc) => Fundraiser.fromJson(doc.data() as Map<String, dynamic>)).toList();
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
                          child: BuildFundingCard(fundraiser: fundraiser),
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
