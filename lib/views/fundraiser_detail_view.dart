import 'package:cached_network_image/cached_network_image.dart';
import 'package:donative/app/features/button_widget.dart';
import 'package:donative/app/features/custom_info_text.dart';
import 'package:donative/app/features/form_container_widget.dart';
import 'package:donative/app/features/toast.dart';
import 'package:donative/app/models/fundraiser.dart';
import 'package:donative/app/user_auth/database_methods.dart';
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

  String transactionId = DateTime.now().millisecondsSinceEpoch.toString();

  uploadPaymentsData() async {
    Map<String, dynamic> paymentsData = {
      "name": nameController.text,
      "amount": amountController.text,
      "upiNumber": upiNumberController.text,
      "fundraiserId": widget.fundraiser.fundraiserId,
      "userId": widget.fundraiser.uid,
      "date_time": DateTime.now(),
      "transactionId": transactionId,
    };
    DatabaseMethods().addPayments(paymentsData);
  }

  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final upiNumberController = TextEditingController();

  String? validateInputBox(String? value) {
    if (value!.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    upiNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progressPercentage =
        ((widget.fundraiser.raisedAmount / widget.fundraiser.totalAmount) *
            100);
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.handHoldingMedical,
                          size: 14,
                        ),
                        label: const Text(
                          "Donation List",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: Theme.of(context).colorScheme.surface,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomInfoText(
                          cardText: widget.fundraiser.title,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          cardColor: Colors.grey[200]!,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Initiated by: ${widget.fundraiser.initiator}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 15),
                        CustomInfoText(
                          cardText: "DESCRIPTION",
                          cardColor: Colors.grey[200]!,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.fundraiser.description!,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 15),
                        CustomInfoText(
                          cardText: "CONTACT DETAILS",
                          cardColor: Colors.grey[200]!,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.fundraiser.mobileNumber ?? 'Not Available',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 15),
                        CustomInfoText(
                          cardText: "HOSPITAL",
                          cardColor: Colors.grey[200]!,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.fundraiser.hospitalName ?? 'Not Available',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 15),
                        CustomInfoText(
                          cardText: "PATIENT ADDRESS",
                          cardColor: Colors.grey[200]!,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.fundraiser.address ?? 'Not Available',
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

  Future<dynamic> cardFromBottom(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.fromLTRB(
              16, 16, 16, MediaQuery.of(context).viewInsets.bottom),
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
                    const Center(child: CircularProgressIndicator.adaptive()),
                  if (!isLoading)
                    ButtonWidget(
                        onTap: () async {
                          if (_paymentKey.currentState!.validate()) {
                            setState(() {
                              isLoading = false;
                            });
                            await Future.delayed(const Duration(seconds: 5),
                                () {
                              setState(() {
                                isLoading = true;
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Transaction Successful'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          uploadPaymentsData().then((value) {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const PaymentView(),
                                              ),
                                            );
                                          });
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
                        buttonText: "Pay"),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
