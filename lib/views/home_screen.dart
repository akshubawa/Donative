import 'package:flutter/material.dart';

import '../app/features/build_funding_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left: 16.0, right: 16.0),
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
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Handle search action
                },
              ),
            ],
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: const [
                BuildFundingCard(
                    title: 'Cancer Funding',
                    initiator: 'Mr. Ram Mohan Joshi',
                    imageUrl: 'lib/app/assets/cancer_image.jpg',
                    raisedAmount: 300,
                    totalAmount: 1000),
                BuildFundingCard(
                    title: 'Liver Transplant Funding',
                    initiator: 'Mrs. Geeta Rawat',
                    imageUrl: 'lib/app/assets/liver_transplant_image.jpg',
                    raisedAmount: 2500,
                    totalAmount: 10000),
                // BuildFundingCard(
                //   title: 'Heart Surgery Funding',
                //   initiator: 'Mr. Manohar Kumar',
                //   imageUrl: 'lib/app/assets/heart_surgery_image.jpg',
                //   raisedAmount: 1500,
                //   totalAmount: 5000,
                // ),
                // BuildFundingCard(
                //   title: 'Kidney Transplant Funding',
                //   initiator: 'Miss. Anjali Singh',
                //   imageUrl: 'lib/app/assets/kidney_transplant_image.jpg',
                //   raisedAmount: 2000,
                //   totalAmount: 8000,
                // ),
                // BuildFundingCard(
                //   title: 'Lung Disease Treatment Funding',
                //   initiator: 'Mr. Ramesh Kumar',
                //   imageUrl: 'lib/app/assets/lung_disease_image.jpg',
                //   raisedAmount: 1200,
                //   totalAmount: 4000,
                // ),
                // BuildFundingCard(
                //   title: 'Diabetes Research Funding',
                //   initiator: 'Mrs. Sunita Sharma',
                //   imageUrl: 'lib/app/assets/diabetes_research_image.jpg',
                //   raisedAmount: 1800,
                //   totalAmount: 6000,
                // ),
                // BuildFundingCard(
                //   title: 'Alzheimer\'s Care Funding',
                //   initiator: 'Mr. Rakesh Singh',
                //   imageUrl: 'lib/app/assets/alzheimers_care_image.jpg',
                //   raisedAmount: 2200,
                //   totalAmount: 7000,
                // ),
                // BuildFundingCard(
                //   title: 'Spinal Cord Injury Treatment Funding',
                //   initiator: 'Miss. Ritu Singh',
                //   imageUrl: 'lib/app/assets/spinal_cord_injury_image.jpg',
                //   raisedAmount: 2700,
                //   totalAmount: 9000,
                // ),
                // BuildFundingCard(
                //   title: 'Rare Disease Treatment Funding',
                //   initiator: 'Mr. Manoj Kumar',
                //   imageUrl: 'lib/app/assets/rare_disease_image.jpg',
                //   raisedAmount: 1900,
                //   totalAmount: 7000,
                // ),
                // BuildFundingCard(
                //   title: 'Mental Health Awareness Funding',
                //   initiator: 'Mind Matters Organization',
                //   imageUrl: 'lib/app/assets/mental_health_image.jpg',
                //   raisedAmount: 1400,
                //   totalAmount: 5000,
                // ),

                // Add more cards as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
