// import 'package:donative/app/features/custom_info_text.dart';
// import 'package:donative/app/models/fundraiser.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

// class BuildFundingCard extends StatelessWidget {
//   const BuildFundingCard({
//     super.key,
//     required this.fundraiser,
//     this.showStatus = false,
//   });

//   final Fundraiser fundraiser;
//   final bool showStatus;

//   @override
//   Widget build(BuildContext context) {
//     // Calculate the percentage of money raised
//     double progressPercentage =
//         ((fundraiser.raisedAmount / fundraiser.totalAmount) * 100);

//     return Padding(
//       padding:
//           const EdgeInsets.only(top: 5.0, bottom: 3.0, left: 10.0, right: 5.0),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         elevation: 5,
//         child: Stack(children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(10.0),
//                   topRight: Radius.circular(10.0),
//                 ),
//                 child: Hero(
//                   tag: fundraiser.image,
//                   child: Image.network(
//                     fundraiser.image,
//                     height: 180,
//                     width: double.maxFinite,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomInfoText(
//                       cardColor: Colors.grey[300]!,
//                       cardText: fundraiser.title,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,

//                     ),

//                     const SizedBox(height: 4),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 2.0),
//                       child: Text(
//                         'Initiated by: ${fundraiser.initiator}',
//                         style: TextStyle(
//                           color: Theme.of(context).colorScheme.outline,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 4),

//                     // LinearProgressIndicator for fundraising progress
//                     Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Raised: ₹${fundraiser.raisedAmount.toInt()}',
//                             style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           CustomInfoText(
//                             cardColor: Colors.grey[300]!,
//                             cardText:
//                                 'Total: ₹${fundraiser.raisedAmount.toInt()}',
//                             textElevation: 0.5,
//                           ),
//                         ]),
//                     const SizedBox(height: 8),
//                     // Stack for combining progress bar and raised amount
//                     FAProgressBar(
//                       currentValue: progressPercentage,
//                       displayText: '%',
//                       displayTextStyle: TextStyle(
//                         color: Theme.of(context).colorScheme.onPrimaryContainer,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       animatedDuration: const Duration(milliseconds: 800),
//                       backgroundColor: Theme.of(context).colorScheme.surface,
//                       progressColor:
//                           Theme.of(context).colorScheme.primaryContainer,
//                       size: 20,
//                     ),
//                     const SizedBox(height: 8),
//                     if (showStatus)
//                       Text(
//                         'Status: ${fundraiser.isApproved ? 'Approved' : 'Pending'}',
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ]),
//       ),
//     );
//   }
// }

import 'package:donative/app/features/custom_info_text.dart';
import 'package:donative/app/models/fundraiser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class BuildFundingCard extends StatefulWidget {
  const BuildFundingCard({
    Key? key,
    required this.fundraiser,
    this.showStatus = false,
  }) : super(key: key);

  final Fundraiser fundraiser;
  final bool showStatus;

  @override
  _BuildFundingCardState createState() => _BuildFundingCardState();
}

class _BuildFundingCardState extends State<BuildFundingCard> {
  bool get canRaiseFunds =>
      widget.fundraiser.raisedAmount < widget.fundraiser.totalAmount;

  bool get isFullyFunded =>
      widget.fundraiser.raisedAmount >= widget.fundraiser.totalAmount;

  @override
  Widget build(BuildContext context) {
    double progressPercentage =
        ((widget.fundraiser.raisedAmount / widget.fundraiser.totalAmount) *
            100);

    return Padding(
        padding: const EdgeInsets.only(
            top: 5.0, bottom: 3.0, left: 10.0, right: 5.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      child: Hero(
                        tag: widget.fundraiser.image,
                        child: Image.network(
                          widget.fundraiser.image,
                          height: 180,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomInfoText(
                            cardColor: Colors.grey[300]!,
                            cardText: widget.fundraiser.title,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),

                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Text(
                              'Initiated by: ${widget.fundraiser.initiator}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),

                          // LinearProgressIndicator for fundraising progress
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Raised: ₹${widget.fundraiser.raisedAmount.toInt()}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                CustomInfoText(
                                  cardColor: Colors.grey[300]!,
                                  cardText:
                                      'Total: ₹${widget.fundraiser.totalAmount.toInt()}',
                                  textElevation: 0.5,
                                ),
                              ]),
                          const SizedBox(height: 8),
                          // Stack for combining progress bar and raised amount
                          FAProgressBar(
                            currentValue: progressPercentage,
                            displayText: '%',
                            displayTextStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontWeight: FontWeight.w500,
                            ),
                            animatedDuration: const Duration(milliseconds: 800),
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            progressColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            size: 20,
                          ),
                          const SizedBox(height: 8),
                          if (widget.showStatus)
                            Text(
                              'Status: ${widget.fundraiser.isApproved ? 'Approved' : 'Pending'}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (isFullyFunded)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
