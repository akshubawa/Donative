import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donative/app/features/build_funding_card.dart';
import 'package:donative/app/models/fundraiser.dart';
import 'package:donative/views/fundraiser_detail_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();

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
                    controller: _searchController,
                    onChanged: (value) {
                      // Trigger a rebuild with the updated search text
                      setState(() {});
                    },
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
                    _performSearch();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('fundraisers')
                  .where('isApproved', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
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
                  final fundraisers = snapshot.data!.docs
                      .map((doc) => Fundraiser.fromJson(
                          doc.data() as Map<String, dynamic>))
                      .toList();

                  // Filter fundraisers based on search text
                  final filteredFundraisers = _searchController.text.isEmpty
                      ? fundraisers
                      : fundraisers
                          .where((fundraiser) =>
                              fundraiser.title.toLowerCase().contains(
                                  _searchController.text.toLowerCase()) ||
                              fundraiser.description!.toLowerCase().contains(
                                  _searchController.text.toLowerCase()))
                          .toList();

                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final fundraiser = filteredFundraisers[index];
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
                          child: BuildFundingCard(
                            fundraiser: fundraiser,
                            showStatus: false,
                          ),
                        );
                      },
                      itemCount: filteredFundraisers.length,
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

  void _performSearch() {
    FocusScope.of(context).unfocus();
    print('Search Button Pressed');
  }
}
