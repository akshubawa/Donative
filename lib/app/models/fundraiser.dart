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
  String? hospitalName;
  String? mobileNumber;
  String? address;
  String uid;
  String fundraiserId;
  bool isApproved;

  Fundraiser({
    required this.title,
    this.description,
    required this.initiator,
    required this.image,
    required this.raisedAmount,
    required this.totalAmount,
    this.hospitalName,
    this.mobileNumber,
    this.address,
    required this.uid,
    required this.fundraiserId,
    required this.isApproved,
  });

  factory Fundraiser.fromJson(Map<String, dynamic> json) {
    return Fundraiser(
      title: json['title'] as String,
      description: json['description'] as String?,
      initiator: json['initiator'] as String,
      image: json['image'] as String,
      raisedAmount: (json['raisedAmount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      hospitalName: json['hospitalName'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      address: json['address'] as String?,
      uid: json['uid'] as String,
      fundraiserId: json['fundraiserId'] as String,
      isApproved: json['isApproved'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'inititor': initiator,
      'image': image,
      'raisedAmount': raisedAmount,
      'totalAmount': totalAmount,
      'hospitalName': hospitalName,
      'mobileNumber': mobileNumber,
      'address': address,
      'uid': uid,
      'fundraiserId': fundraiserId,
      'isApproved': false,
    };
  }
}

FundraiserData fundraiserDataFromJson(String str) {
  final jsonData = json.decode(str) as Map<String, dynamic>;
  return FundraiserData.fromJson(jsonData);
}

String fundraiserDataToJson(FundraiserData data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
