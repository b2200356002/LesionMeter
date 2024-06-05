import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/file_repository.dart';
import '../../domain/repositories/skin_repository.dart';
import '../../router/router.dart';
import '../../services/multimedia/multimedia.dart';
import 'locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: true)
void configureDependencies() => getIt.init();

final skinRepositoryProvider = Provider.autoDispose((ref) => getIt<SkinRepository>());
final multimediaProvider = Provider.autoDispose((ref) => getIt<Multimedia>());
final appRouterProvider = Provider.autoDispose((ref) => getIt<AppRouter>());
final fileRepositoryProvider = Provider.autoDispose((ref) => getIt<FileRepository>());
