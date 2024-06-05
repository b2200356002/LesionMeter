import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import 'multimedia.dart';

@LazySingleton(as: Multimedia)
class MultimediaImpl implements Multimedia {
  final ImagePicker imagePicker;

  const MultimediaImpl({required this.imagePicker});

  @override
  Future<List<XFile>> pickMultiImage() async {
    try {
      return imagePicker.pickMultiImage();
    } catch (e) {
      return [];
    }
  }
}
