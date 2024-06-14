class TestModel {
  final phone1;
  final phone2;

  TestModel({
    required this.phone1,
    required this.phone2,
  });

  factory TestModel.fromJson(Map<dynamic, dynamic> json) {
    return TestModel(
      phone1: json['01011111111'],
      phone2: json['01022222222'],
    );
  }
}
