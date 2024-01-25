import 'package:cached_network_image/cached_network_image.dart';
import 'package:donative/app/features/button_widget.dart';
import 'package:donative/app/models/fundraiser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class FundraiserDetailView extends StatelessWidget {
  const FundraiserDetailView({super.key, required this.fundraiser});

  final Fundraiser fundraiser;

  @override
  Widget build(BuildContext context) {
    double progressPercentage =
        ((fundraiser.raisedAmount / fundraiser.totalAmount) * 100);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: const Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Hero(
                        tag: fundraiser.image,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            cacheKey: fundraiser.image,
                            imageUrl: fundraiser.image,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Text("Raised Amount: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
                          Text(
                            fundraiser.raisedAmount.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Total Amount: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
                          Text(
                            fundraiser.totalAmount.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      FAProgressBar(
                        currentValue: progressPercentage,
                        displayText: '%',
                        displayTextStyle: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                        animatedDuration: const Duration(milliseconds: 800),
                        backgroundColor:
                            Theme.of(context).colorScheme.surfaceVariant,
                        progressColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        size: 20,
                      ),
                      const SizedBox(height: 10),
                      ButtonWidget(onTap: () {}, buttonText: "DONATE NOW"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fundraiser.title,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Initiated by: ${fundraiser.initiator}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text("DESCRIPTION",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontSize: 18,
                            )),
                        const SizedBox(height: 4),
                        Text(
                          fundraiser.description!,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text("CONTACT DETAILS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontSize: 18,
                            )),
                        const SizedBox(height: 4),
                        Text(
                          fundraiser.mobileNumber ?? 'Not Available',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text("HOSPITAL",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontSize: 18,
                            )),
                        const SizedBox(height: 4),
                        Text(
                          fundraiser.hospitalName ?? 'Not Available',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text("PATIENT ADDRESS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            )),
                        const SizedBox(height: 4),
                        Text(
                          fundraiser.address ?? 'Not Available',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }
}
