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
                // BACKGROUND COLOR OF CARD
                color: Theme.of(context).colorScheme.secondary,
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
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                      animatedDuration: const Duration(milliseconds: 800),
                      backgroundColor: Theme.of(context).colorScheme.outline,
                      progressColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      size: 20,
                    ),
                    const SizedBox(height: 10),
                    ButtonWidget(onTap: () {}, buttonText: "DONATE NOW"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
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
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 10),
              const Text("DESCRIPTION",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
              Text(
                fundraiser.description!,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 10),
              const Text("CONTCT DETAILS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
              Text(
                fundraiser.mobileNumber ?? 'Not Available',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 10),
              const Text("HOSPITAL",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
              Text(
                fundraiser.hospitalName ?? 'Not Available',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 10),
              const Text("PATIENT ADDRESS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
              Text(
                fundraiser.address ?? 'Not Available',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }
}
