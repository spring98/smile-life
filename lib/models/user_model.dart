class UserModel {
  final String account;
  final String division;
  final bool isHaveStore;
  final String name;
  final String storeExplain;
  final String storeName;
  final String userPhoto;
  final String phoneNumber;

  UserModel({
    required this.account,
    required this.division,
    required this.isHaveStore,
    required this.name,
    required this.storeExplain,
    required this.storeName,
    required this.userPhoto,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      account: json['account'],
      division: json['division'],
      isHaveStore: json['isHaveStore'],
      name: json['name'],
      storeExplain: json['storeExplain'],
      storeName: json['storeName'],
      userPhoto: json['userPhoto'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
