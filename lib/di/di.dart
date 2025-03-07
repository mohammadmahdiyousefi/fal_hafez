import 'package:dio/dio.dart';
import 'package:fal_hafez/bloc/fal_hafez_bloc/fal_hafez_bloc.dart';
import 'package:fal_hafez/data/datasource/fai_hafez_datasource.dart';
import 'package:fal_hafez/data/repository/fal_hafez_repository.dart';
import 'package:fal_hafez/networkUtil/dio_provide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt locator = GetIt.instance;

Future<void> getItInit() async {
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
  locator.registerSingleton<Dio>(DioProvider.createDio());
  locator.registerSingleton<IFalHafezDatasource>(
    FalHafezDatasource(locator.get()),
  );
  locator.registerSingleton<FalHafezRepository>(
    FalHafezRepositoryImpl(locator.get()),
  );
  locator.registerFactory<FalHafezBloc>(() => FalHafezBloc(locator.get()));
}
