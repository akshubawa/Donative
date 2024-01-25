import 'package:donative/app/models/fundraiser.dart';
import 'package:flutter/material.dart';

class FundraiserDetailView extends StatelessWidget {
  const FundraiserDetailView({super.key, required this.fundraiser});

  final Fundraiser fundraiser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text(
          "Description",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}