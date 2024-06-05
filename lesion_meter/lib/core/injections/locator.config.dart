// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i6;

import 'package:cross_connectivity/cross_connectivity.dart' as _i4;
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:image_picker/image_picker.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i8;

import '../../data/repositories/file_repository_impl.dart' as _i22;
import '../../data/repositories/skin_repository_impl.dart' as _i20;
import '../../domain/repositories/file_repository.dart' as _i21;
import '../../domain/repositories/skin_repository.dart' as _i19;
import '../../router/router.dart' as _i3;
import '../../services/jwt/jwt_service.dart' as _i9;
import '../../services/jwt/jwt_service_impl.dart' as _i10;
import '../../services/locale/locale_resources_service.dart' as _i11;
import '../../services/locale/locale_resources_service_impl.dart' as _i12;
import '../../services/multimedia/multimedia.dart' as _i13;
import '../../services/multimedia/multimedia_impl.dart' as _i14;
import '../../services/network/network_info.dart' as _i15;
import '../../services/network/network_info_impl.dart' as _i16;
import '../../services/network/network_service.dart' as _i17;
import '../../services/network/network_service_impl.dart' as _i18;
import 'register_module.dart' as _i23;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.AppRouter>(() => registerModule.appRouter);
    gh.lazySingleton<_i4.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i5.Dio>(() => registerModule.dio);
    await gh.lazySingletonAsync<_i6.Directory>(
      () => registerModule.applicationDocumentsDirectory,
      instanceName: 'applicationDocumentsDirectory',
      preResolve: true,
    );
    gh.lazySingleton<_i7.ImagePicker>(() => registerModule.imagePicker);
    await gh.lazySingletonAsync<_i8.Isar>(
      () => registerModule.getIsar(
          gh<_i6.Directory>(instanceName: 'applicationDocumentsDirectory')),
      preResolve: true,
    );
    gh.lazySingleton<_i9.JwtService>(() => _i10.JwtServiceImpl());
    gh.lazySingleton<_i11.LocaleResourcesService>(
        () => _i12.LocaleResourcesServiceImpl(isar: gh<_i8.Isar>()));
    gh.lazySingleton<_i13.Multimedia>(
        () => _i14.MultimediaImpl(imagePicker: gh<_i7.ImagePicker>()));
    gh.lazySingleton<_i15.NetworkInfo>(
        () => _i16.NetworkInfoImpl(connectivity: gh<_i4.Connectivity>()));
    gh.lazySingleton<_i17.NetworkService>(() => _i18.NetworkServiceImpl(
          gh<_i5.Dio>(),
          networkInfo: gh<_i15.NetworkInfo>(),
        ));
    gh.lazySingleton<_i19.SkinRepository>(() => _i20.SkinRepositoryImpl(
          localeResourcesService: gh<_i11.LocaleResourcesService>(),
          networkService: gh<_i17.NetworkService>(),
        ));
    gh.lazySingleton<_i21.FileRepository>(
        () => _i22.FileRepositoryImpl(gh<_i11.LocaleResourcesService>()));
    return this;
  }
}

class _$RegisterModule extends _i23.RegisterModule {
  @override
  _i3.AppRouter get appRouter => _i3.AppRouter();

  @override
  _i4.Connectivity get connectivity => _i4.Connectivity();

  @override
  _i7.ImagePicker get imagePicker => _i7.ImagePicker();
}
