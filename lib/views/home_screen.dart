import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Positioned(
            top: 300,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
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
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                buildFundingCard(
                  title: 'Cancer Funding',
                  initiator: 'XYZ Organization',
                  imageUrl: 'lib/app/assets/cancer_image.webp',
                ),
                buildFundingCard(
                  title: 'Liver Transplant Funding',
                  initiator: 'ABC Foundation',
                  imageUrl: 'lib/app/assets/liver_transplant_image.jpg',
                ),
                buildFundingCard(
                  title: 'Liver Transplant Funding',
                  initiator: 'ABC Foundation',
                  imageUrl: 'lib/app/assets/liver_transplant_image.jpg',
                ),
                buildFundingCard(
                  title: 'Liver Transplant Funding',
                  initiator: 'ABC Foundation',
                  imageUrl: 'lib/app/assets/liver_transplant_image.jpg',
                ),
                // Add more cards as needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFundingCard({
    required String title,
    required String initiator,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.asset(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Initiated by: $initiator',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
