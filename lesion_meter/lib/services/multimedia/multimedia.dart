import 'package:image_picker/image_picker.dart';

abstract class Multimedia {
  Future<List<XFile>> pickMultiImage();
}
