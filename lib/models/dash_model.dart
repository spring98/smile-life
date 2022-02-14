class DashModel {
  final String spotAverageTemperature;
  final String spotAverageHumidity;
  final String spotAverageEC;
  final String spotAveragePH;
  final String spotAverageN;
  final String spotAverageP;
  final String spotAverageK;
  final String spotLocation;
  final String addressDetails;
  final String company;
  final String status;

  DashModel(
      {required this.spotAverageTemperature,
      required this.spotAverageHumidity,
      required this.spotAverageEC,
      required this.spotAveragePH,
      required this.spotAverageN,
      required this.spotAverageP,
      required this.spotAverageK,
      required this.status,
      required this.spotLocation,
      required this.addressDetails,
      required this.company});

  factory DashModel.fromJson(Map<String, dynamic> json) {
    return DashModel(
        spotLocation: json['spot'],
        spotAverageTemperature: json['temperature'].toString(),
        spotAverageHumidity: json['moisture'].toString(),
        spotAverageEC: json['ec'].toString(),
        spotAveragePH: json['ph'].toString(),
        spotAverageN: json['n'].toString(),
        spotAverageP: json['p'].toString(),
        spotAverageK: json['k'].toString(),
        status: json['status'],
        addressDetails: json['address'],
        company: json['admin']);
  }
}
