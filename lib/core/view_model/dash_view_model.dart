// import 'package:get/get.dart';
// import 'package:sungha/core/services/dash_service.dart';
// import 'package:sungha/models/dash_model.dart';
// import 'package:sungha/utils/constants.dart';
//
// // enum Flag {
// //   TEMP_HIGH,
// //   TEMP_NORMAL,
// //   TEMP_LOW,
// //   HUMID_HIGH,
// //   HUMID_NORMAL,
// //   HUMID_LOW,
// //   PH_HIGH,
// //   PH_NORMAL,
// //   PH_LOW,
// //   EC_HIGH,
// //   EC_NORMAL,
// //   EC_LOW,
// //   N_HIGH,
// //   N_NORMAL,
// //   N_LOW,
// //   P_HIGH,
// //   P_NORMAL,
// //   P_LOW,
// //   K_HIGH,
// //   K_NORMAL,
// //   K_LOW,
// // }
//
// class DashViewModel extends GetxController {
//   DashService _dashService = DashService();
//
//   /// fetch data
//   List<DashModel> _dashModel = [];
//   List<DashModel> get getDashModel => _dashModel;
//
//   /// member field
//   /// 온도 20-30, 습도 10-30, 산도 5-9, 전도도 300-500, 나머지 1-2
//   List<dynamic> getStatus(int index) {
//     double temperature =
//         double.parse(getDashModel[index].spotAverageTemperature);
//     double humidity = double.parse(getDashModel[index].spotAverageHumidity);
//     double ec = double.parse(getDashModel[index].spotAverageEC);
//     double ph = double.parse(getDashModel[index].spotAveragePH);
//     double n = double.parse(getDashModel[index].spotAverageN);
//     double p = double.parse(getDashModel[index].spotAverageP);
//     double k = double.parse(getDashModel[index].spotAverageK);
//
//     // -1 : 낮음, 0 : 정상, 1 : 높음
//     int temperFlag = 0;
//     int humidityFlag = 0;
//     int ecFlag = 0;
//     int phFlag = 0;
//     int nFlag = 0;
//     int pFlag = 0;
//     int kFlag = 0;
//
//     List<dynamic> returnValue = [];
//     int flagCount = 0;
//     String status = '';
//
//     if (temperature < 20) {
//       temperFlag = -1;
//
//       flagCount++;
//       status = '온도 낮음';
//     }
//     if (temperature > 30) {
//       temperFlag = 1;
//
//       flagCount++;
//       status = '온도 높음';
//     }
//
//     if (humidity < 10) {
//       humidityFlag = -1;
//       flagCount++;
//       status = '습도 낮음';
//     }
//     if (humidity > 30) {
//       humidityFlag = 1;
//       flagCount++;
//       status = '습도 높음';
//     }
//
//     /// 온도 20-30, 습도 10-30, 산도 5-9, 전도도 300-500, 나머지 1-2
//
//     if (ec > 500) {
//       ecFlag = 1;
//       flagCount++;
//       status = '전도도 높음';
//     }
//     if (ec < 300) {
//       ecFlag = -1;
//       flagCount++;
//       status = '전도도 낮음';
//     }
//
//     if (ph > 9) {
//       phFlag = 1;
//       flagCount++;
//       status = '산도 높음';
//     }
//     if (ph < 5) {
//       phFlag = -1;
//       flagCount++;
//       status = '산도 낮음';
//     }
//
//     if (n > 2) {
//       nFlag = 1;
//       flagCount++;
//       status = '질소 높음';
//     }
//     if (n < 1) {
//       nFlag = -1;
//       flagCount++;
//       status = '질소 낮음';
//     }
//
//     if (p > 2) {
//       pFlag = 1;
//       flagCount++;
//       status = '인 높음';
//     }
//     if (p < 1) {
//       pFlag = -1;
//       flagCount++;
//       status = '인 낮음';
//     }
//
//     if (k > 2) {
//       kFlag = 1;
//       flagCount++;
//       status = '칼륨 높음';
//     }
//     if (k < 1) {
//       kFlag = -1;
//       flagCount++;
//       status = '칼륨 낮음';
//     }
//
//     if (flagCount >= 2) {
//       status = '위험';
//     }
//
//     if (flagCount == 0) {
//       status = '정상';
//     }
//
//     returnValue.add(temperFlag);
//     returnValue.add(humidityFlag);
//     returnValue.add(phFlag);
//     returnValue.add(nFlag);
//     returnValue.add(pFlag);
//     returnValue.add(kFlag);
//     returnValue.add(ecFlag);
//
//     returnValue.add(status);
//
//     return returnValue;
//   }
//
//   Future<List<DashModel>> fetchDash() async {
//     List<dynamic> result = await _dashService.fetchDash();
//     _dashModel = [];
//     for (int i = 0; i < result.length; i++) {
//       _dashModel.add(DashModel.fromJson(result[i]));
//     }
//     update();
//     setDropDown();
//     return getDashModel;
//   }
//
//   // void fetchDash() {
//   //   _dashService.fetchDash().then((result) {
//   //     _dashModel = [];
//   //     for (int i = 0; i < result.length; i++) {
//   //       _dashModel.add(DashModel.fromJson(result[i]));
//   //     }
//   //     update();
//   //     setDropDown();
//   //   });
//   // }
//
//   void setDropDown() {
//     spotNameValue = '';
//     spotList = [];
//
//     for (int i = 0; i < getDashModel.length; i++) {
//       if (getDashModel.isNotEmpty) {
//         if (i == 0) {
//           spotNameValue = getDashModel[i].spotLocation;
//         }
//         spotList.add(getDashModel[i].spotLocation);
//       }
//     }
//   }
// }
