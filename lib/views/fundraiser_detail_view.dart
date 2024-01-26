import 'package:cached_network_image/cached_network_image.dart';
import 'package:donative/app/features/button_widget.dart';
import 'package:donative/app/features/form_container_widget.dart';
import 'package:donative/app/features/toast.dart';
import 'package:donative/app/models/fundraiser.dart';
import 'package:donative/views/payment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _paymentKey = GlobalKey<FormState>();

class FundraiserDetailView extends StatefulWidget {
  const FundraiserDetailView({super.key, required this.fundraiser});

  final Fundraiser fundraiser;

  @override
  State<FundraiserDetailView> createState() => _FundraiserDetailViewState();
}

class _FundraiserDetailViewState extends State<FundraiserDetailView> {
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController upiNumberController = TextEditingController();

  String? validateInputBox(String? value) {
    if (value!.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  //   KeyboardVisibilityController().onChange.listen((bool isVisible) {
  //   if (!isVisible) {
  //     // Keyboard is hidden, you can close the bottom sheet here
  //     Navigator.of(context).pop();
  //   }
  // });
  }

  @override
  Widget build(BuildContext context) {
    double progressPercentage =
        ((widget.fundraiser.raisedAmount / widget.fundraiser.totalAmount) *
            100);
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                        tag: widget.fundraiser.image,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            cacheKey: widget.fundraiser.image,
                            imageUrl: widget.fundraiser.image,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text("Raised Amount: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
                          Text(
                            widget.fundraiser.raisedAmount.toString(),
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
                            widget.fundraiser.totalAmount.toString(),
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
                      ButtonWidget(
                        onTap: () {
                          cardFromBottom(context);
                        },
                        buttonText: "DONATE NOW",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.fundraiser.title,
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Initiated by: ${widget.fundraiser.initiator}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
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
                        widget.fundraiser.description!,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
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
                        widget.fundraiser.mobileNumber ?? 'Not Available',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
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
                        widget.fundraiser.hospitalName ?? 'Not Available',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
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
                        widget.fundraiser.address ?? 'Not Available',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ]),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }

  Future<dynamic> cardFromBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _paymentKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    FontAwesomeIcons.handHoldingHeart,
                    color: Theme.of(context).colorScheme.primary,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text("Thanks for being a part of this cause!",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  const SizedBox(height: 16),
                  FormContainerWidget(
                      labelText: "Enter your Name",
                      controller: nameController,
                      isPasswordField: false,
                      textInputType: TextInputType.name,
                      validateInputBox: validateInputBox),
                  const SizedBox(height: 16),
                  FormContainerWidget(
                      labelText: "Enter your amount",
                      controller: amountController,
                      isPasswordField: false,
                      textInputType: TextInputType.number,
                      validateInputBox: validateInputBox),
                  const SizedBox(height: 16),
                  FormContainerWidget(
                      labelText: "Enter your UPI",
                      controller: upiNumberController,
                      isPasswordField: false,
                      textInputType: TextInputType.text,
                      validateInputBox: validateInputBox),
                  const SizedBox(height: 16),
                  if (isLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (!isLoading)
                    ButtonWidget(
                        onTap: () async {
                          if (_paymentKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            Future.delayed(const Duration(seconds: 5), () {
                              setState(() {
                                isLoading = false;
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Transaction Successful'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          // Navigate to PaymentView page
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const PaymentView(),
                                            ),
                                          );
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                          } else {
                            showToast(
                                message: "Please fill all the required fields",
                                context: context);
                          }
                        },
                        buttonText: "Pay")
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
