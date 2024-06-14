import 'package:image_picker/image_picker.dart';

Future<String> getPicker() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  print('======================= In getPicker()==================');
  if (image != null) {
    // print('getPicker image not null entered ! ');
    // print(image.path);
    return image.path;
  } else {
    return '';
  }
}
