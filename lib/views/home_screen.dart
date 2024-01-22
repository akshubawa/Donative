import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crowd Funding App'),
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
                    padding: const EdgeInsets.only(left: 12.0),
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
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Handle search action
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 570,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                buildFundingCard(
                    title: 'Cancer Funding',
                    initiator: 'XYZ Organization',
                    imageUrl: 'lib/app/assets/cancer_image.webp',
                    raisedAmount: 500,
                    totalAmount: 1000),
                buildFundingCard(
                    title: 'Liver Transplant Funding',
                    initiator: 'ABC Foundation',
                    imageUrl: 'lib/app/assets/liver_transplant_image.jpg',
                    raisedAmount: 500,
                    totalAmount: 1000),
                buildFundingCard(
                    title: 'Liver Transplant Funding',
                    initiator: 'ABC Foundation',
                    imageUrl: 'lib/app/assets/liver_transplant_image.jpg',
                    raisedAmount: 500,
                    totalAmount: 1000),
                buildFundingCard(
                    title: 'Liver Transplant Funding',
                    initiator: 'ABC Foundation',
                    imageUrl: 'lib/app/assets/liver_transplant_image.jpg',
                    raisedAmount: 500,
                    totalAmount: 1000),
                buildFundingCard(
                    title: 'Liver Transplant Funding',
                    initiator: 'ABC Foundation',
                    imageUrl: 'lib/app/assets/liver_transplant_image.jpg',
                    raisedAmount: 500,
                    totalAmount: 1000),
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
    required double raisedAmount,
    required double totalAmount,
  }) {
    // Calculate the percentage of money raised
    double progressPercentage = ((raisedAmount / totalAmount) * 100);

    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 5.0, left: 8.0, right: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.asset(
                imageUrl,
                height: 100,
                width: double.maxFinite,
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Initiated by: $initiator',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),

                  // LinearProgressIndicator for fundraising progress
                  Row(
                    children: [
                      SizedBox(width: 264.7),
                      Text(
                        'Total: \$${totalAmount.toInt()}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Stack for combining progress bar and raised amount
                  FAProgressBar(
                    currentValue: progressPercentage,
                    displayText: '%',
                    animatedDuration: const Duration(milliseconds: 800),
                    backgroundColor: Colors.white,
                    progressColor: Color.fromARGB(255, 103, 103, 103),
                    size: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
