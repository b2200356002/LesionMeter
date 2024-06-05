import 'package:fpdart/fpdart.dart';

import '../../core/models/failure/failure.dart';

abstract interface class FileRepository {
  Future<Either<Failure, Unit>> export();
  Future<Either<Failure, Option<Unit>>> import();
}
