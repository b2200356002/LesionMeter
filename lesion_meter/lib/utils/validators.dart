import 'package:fpdart/fpdart.dart';

import '../constants/value_failure_messages.dart';
import '../core/models/value_failure/value_failure.dart';

Option<ValueFailure> validateEmptiness(String input) {
  if (input.isEmpty) {
    return some(const ValueFailure.invalidInput(emptyInputFailureMessage));
  }

  return none();
}
