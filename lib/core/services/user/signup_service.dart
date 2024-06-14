import 'package:firebase_database/firebase_database.dart';

class SignupService {
  final DatabaseReference _signupRef = FirebaseDatabase.instance.ref('users');

  Future<String> checkPhone(String phone) async {
    DatabaseEvent value = await _signupRef.child(phone).once();
    print(value.snapshot.value);
    if (value.snapshot.value == null) {
      return 'success';
    } else {
      return 'fail';
    }
  }

  Future<void> signup(String pw, String name, String phone) async {
    _signupRef.child(phone).set({
      'name': name,
      'password': pw,
      'account': '',
      'category': '',
      'division': '',
      'isHaveStore': false,
      'storeExplain': '',
      'storeName': '',
      'userPhoto': '',
      'phoneNumber': phone,
    });
  }
}
