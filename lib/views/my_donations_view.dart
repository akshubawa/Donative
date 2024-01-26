import 'package:flutter/material.dart';

class MyDonationsView extends StatelessWidget {
  const MyDonationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: const Text(
            "My Donations",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Card(
                  color: Colors.white,
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Column(children: []))),
            ])));
  }
}
