import 'dart:convert';

class FundraiserData {
  List<Fundraiser> fundraisers;

  FundraiserData({
    required this.fundraisers,
  });

  factory FundraiserData.fromJson(Map<String, dynamic> json) {
    return FundraiserData(
      fundraisers: (json['fundraisers'] as List<dynamic>)
          .map((e) => Fundraiser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fundraisers': fundraisers.map((e) => e.toJson()).toList(),
    };
  }
}

class Fundraiser {
  String title;
  String? description;
  String initiator;
  String image;
  double raisedAmount;
  double totalAmount;

  Fundraiser({
    required this.title,
    this.description,
    required this.initiator,
    required this.image,
    required this.raisedAmount,
    required this.totalAmount,
  });

  factory Fundraiser.fromJson(Map<String, dynamic> json) {
    return Fundraiser(
      title: json['title'] as String,
      description: json['description'] as String?,
      initiator: json['initiator'] as String,
      image: json['image'] as String,
      raisedAmount: (json['raisedAmount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'inititor': initiator,
      'image': image,
      'raisedAmount': raisedAmount,
      'totalAmount': totalAmount
    };
  }
}

// class Description {
//   String initiator;
//   String description;

//   Description({
//     required this.initiator,
//     required this.description,
//   });

//   factory Description.fromJson(Map<String, dynamic> json) {
//     return Description(
//       initiator: json['initiator'] as String,
//       description: json['description'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'initiator': initiator,
//       'description': description,
//     };
//   }
// }

FundraiserData fundraiserDataFromJson(String str) {
  final jsonData = json.decode(str) as Map<String, dynamic>;
  return FundraiserData.fromJson(jsonData);
}

String fundraiserDataToJson(FundraiserData data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
