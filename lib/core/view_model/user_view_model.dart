import 'package:get/get.dart';
import 'package:smile_life/core/services/login_service.dart';
import 'package:smile_life/models/user_model.dart';

class UserViewModel extends GetxController {
  LoginService _loginService = LoginService();

  /// fetch data
  List<UserModel> _userModel = [];
  List<UserModel> get getUserModel => _userModel;

  Future<List<UserModel>> fetchUser() async {
    List<dynamic> result = await _loginService.fetchUser();
    _userModel.add(UserModel.fromJson(result[0]));
    update();
    return getUserModel;
  }
}
