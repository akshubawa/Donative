import 'package:flutter/material.dart';

import '../app/features/build_funding_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text(
          "Donative",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Handle search action
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: const [
                  BuildFundingCard(
                      title: 'Cancer Funding',
                      initiator: 'Mr. Ram Mohan Joshi',
                      imageUrl:
                          'https://img.freepik.com/free-photo/sick-asian-man-sitting-chair-side-view_23-2149870287.jpg?w=1060&t=st=1706010608~exp=1706011208~hmac=262347006e00fe945acafe9ef3f3e7133b7aa6a73654bb97e538c474762e5bd0',
                      raisedAmount: 300,
                      totalAmount: 1000),
                  BuildFundingCard(
                      title: 'Liver Transplant Funding',
                      initiator: 'Mrs. Geeta Rawat',
                      imageUrl:
                          'https://img.freepik.com/free-photo/doctor-holding-patient-medium-shot_23-2148934321.jpg?w=1060&t=st=1706010577~exp=1706011177~hmac=02b4904ce2b76d454e9efaee647706e575794f1c24b3cc41462bb9bff9ed1a2e',
                      raisedAmount: 2500,
                      totalAmount: 10000),
                  BuildFundingCard(
                    title: 'Heart Surgery Funding',
                    initiator: 'Mr. Manohar Kumar',
                    imageUrl:
                        'https://img.freepik.com/free-photo/happy-nurse-holding-elderly-man-hand-wheelchair-garden-nursing-home_554837-197.jpg?w=1060&t=st=1706010552~exp=1706011152~hmac=a7110654e04540453d57ee6c4ce537cafedfad38fd93d0648e526ba8e38c585d',
                    raisedAmount: 1500,
                    totalAmount: 5000,
                  ),
                  BuildFundingCard(
                    title: 'Kidney Transplant Funding',
                    initiator: 'Mr. Taarak Mehta',
                    imageUrl:
                        'https://img.freepik.com/free-photo/attractive-asian-woman-nurse-doctor-working-with-smiling-freshness-together-takecare-ill-old-senior-patient-hospital_609648-2278.jpg?w=1060&t=st=1706009907~exp=1706010507~hmac=9e1aa2be3022675684bce3ee45fb009659649c6c08cc979a6d1e928b817ba8f1',
                    raisedAmount: 2000,
                    totalAmount: 8000,
                  ),
                  BuildFundingCard(
                    title: 'Lung Disease Treatment Funding',
                    initiator: 'Mr. Ramesh Kumar',
                    imageUrl:
                        'https://img.freepik.com/free-photo/senior-man-breathing-with-special-equipment-hospital_23-2149011302.jpg?w=1060&t=st=1706009929~exp=1706010529~hmac=228b16f022a8a6225a183c16c617cc1c6464a656874c4b5deb0e13451749755b',
                    raisedAmount: 1200,
                    totalAmount: 4000,
                  ),
                  BuildFundingCard(
                    title: 'Diabetes Research Funding',
                    initiator: 'Mrs. Sunita Sharma',
                    imageUrl:
                        'https://img.freepik.com/free-photo/senior-woman-talking-with-her-doctor_23-2148962385.jpg?w=1060&t=st=1706010030~exp=1706010630~hmac=b5617a375b00cd736a1915be6c3254dfa92f945508f8fe30f44298aa40e4e762',
                    raisedAmount: 1800,
                    totalAmount: 6000,
                  ),
                  BuildFundingCard(
                    title: 'Alzheimer\'s Care Funding',
                    initiator: 'Mr. Rakesh Singh',
                    imageUrl:
                        'https://img.freepik.com/free-photo/young-man-being-ill-hospital-bed_23-2149017252.jpg?w=1060&t=st=1706009992~exp=1706010592~hmac=54a3d84a98d8a7ff4d784663f3ec2160be8badb435f5b165956667f466a796d7',
                    raisedAmount: 2200,
                    totalAmount: 7000,
                  ),
                  BuildFundingCard(
                    title: 'Spinal Cord Injury Treatment Funding',
                    initiator: 'Miss. Ritu Singh',
                    imageUrl:
                        'https://img.freepik.com/free-photo/medium-shot-nurse-doctor-checking-patient_23-2148973496.jpg?w=1060&t=st=1706010072~exp=1706010672~hmac=e995017419f9c6eb6a45bb17fadb8415c30d2b9922f93ce194180490d57caa99',
                    raisedAmount: 2700,
                    totalAmount: 9000,
                  ),
                  BuildFundingCard(
                    title: 'Rare Disease Treatment Funding',
                    initiator: 'Mr. Manoj Kumar',
                    imageUrl:
                        'https://img.freepik.com/free-photo/doctor-helping-patient-during-rehabilitation_23-2150321564.jpg?w=1060&t=st=1706010098~exp=1706010698~hmac=c154c594d744643a52d7d5644318b3f45d58db7913d90a0affec5737e6b008bc',
                    raisedAmount: 1900,
                    totalAmount: 7000,
                  ),
                  BuildFundingCard(
                    title: 'Mental Health Awareness Funding',
                    initiator: 'Mind Matters Organization',
                    imageUrl:
                        'https://img.freepik.com/free-photo/front-view-female-doctors-patient_23-2149844600.jpg?w=1060&t=st=1706010129~exp=1706010729~hmac=07857b8c6835d06be6a5eef623d3aec43575ad77e580f82fea2d33d19636a3e7',
                    raisedAmount: 1400,
                    totalAmount: 5000,
                  ),

                  // Add more cards as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
