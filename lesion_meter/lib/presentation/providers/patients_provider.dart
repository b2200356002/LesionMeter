import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lesion_meter/core/injections/locator.dart';

final patientsProvider = StreamProvider.autoDispose((ref) async* {
  yield* ref.watch(skinRepositoryProvider).watchPatients();
});
