import 'package:isar/isar.dart';

part 'uint8list_image.g.dart';

@embedded
final class Uint8ListImage {
  List<byte>? value;

  Uint8ListImage([this.value]);
}
