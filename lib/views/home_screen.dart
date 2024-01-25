import 'package:donative/app/features/build_funding_card.dart';
import 'package:donative/app/models/fundraiser.dart';
import 'package:donative/views/fundraiser_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Fundraiser>> loadFundraisers() async {
    final rawFundraisers =
        await rootBundle.loadString("assets/fundraiser.json");
    // print("RAW FUNDRAISERS: $rawFundraisers");
    await Future.delayed(const Duration(seconds: 1));
    final fundraisers = fundraiserDataFromJson(rawFundraisers);
    // print("FUNDRAISERS: $fundraisers");
    return fundraisers.fundraisers;
  }

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
            FutureBuilder<List<Fundraiser>>(
              future: loadFundraisers(),
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
                  final fundraisers = snapshot.data as List<Fundraiser>;
                  return SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.85,
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
