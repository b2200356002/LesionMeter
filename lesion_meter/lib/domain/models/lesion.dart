import 'package:isar/isar.dart';

part 'lesion.g.dart';

@Embedded(inheritance: false)
final class Lesion {
  double? area;

  Lesion({this.area});
}
