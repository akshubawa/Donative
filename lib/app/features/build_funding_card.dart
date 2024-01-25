import 'package:donative/app/models/fundraiser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class BuildFundingCard extends StatelessWidget {
  const BuildFundingCard({
    super.key,
    required this.fundraiser,
  });

  final Fundraiser fundraiser;

  @override
  Widget build(BuildContext context) {
    // Calculate the percentage of money raised
    double progressPercentage =
        ((fundraiser.raisedAmount / fundraiser.totalAmount) * 100);

    return Padding(
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 3.0, left: 16.0, right: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Hero(
                  tag: fundraiser.image,
                  child: Image.network(
                    fundraiser.image,
                    height: 180,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      fundraiser.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Initiated by: ${fundraiser.initiator}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // LinearProgressIndicator for fundraising progress
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Raised: ₹${fundraiser.raisedAmount.toInt()}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Total: ₹${fundraiser.totalAmount.toInt()}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ]),
                    const SizedBox(height: 8),
                    // Stack for combining progress bar and raised amount
                    FAProgressBar(
                      currentValue: progressPercentage,
                      displayText: '%',
                      displayTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                      animatedDuration: const Duration(milliseconds: 800),
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      progressColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      size: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
