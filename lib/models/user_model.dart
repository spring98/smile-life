class UserModel {
  final String id;
  final String name;
  final String phone;
  final String division;
  final String rank;
  // final String corPicture;

  UserModel(
      {required this.id,
      required this.name,
      required this.phone,
      required this.division,
      required this.rank});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user_id'],
      name: json['user_name'],
      phone: json['phone_number'],
      division: json['division'],
      rank: json['position'],
    );
  }
}
