import 'package:donative/app/models/payments.dart';
import 'package:flutter/material.dart';

class MyDonationCard extends StatelessWidget {
  const MyDonationCard({
    super.key,
    required this.payment,
  });

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    // Calculate the percentage of money raised
    return Padding(
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 3.0, left: 16.0, right: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Name: ${payment.name}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text("Amount: ₹${payment.amount}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
                Text(
                    "Date: ${payment.date_time.toDate().toString().substring(0, 10)}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
                Text("Transaction ID: ${payment.transactionId}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
                Text("Paid by Upi: ${payment.upiNumber}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
