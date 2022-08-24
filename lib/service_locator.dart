import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rickandmorty_ca_test/core/dio/dio_singleton.dart';
import 'package:rickandmorty_ca_test/core/platform/network_info.dart';
import 'package:rickandmorty_ca_test/core/platform/network_info_impl.dart';
import 'package:rickandmorty_ca_test/data/datasources/person_local_ds/person_local_ds.dart';
import 'package:rickandmorty_ca_test/data/datasources/person_local_ds/person_local_ds_impl.dart';
import 'package:rickandmorty_ca_test/data/datasources/person_remote_ds/person_remote_ds.dart';
import 'package:rickandmorty_ca_test/data/datasources/person_remote_ds/person_remote_ds_impl.dart';
import 'package:rickandmorty_ca_test/data/repositories/person_repository_impl.dart';
import 'package:rickandmorty_ca_test/domain/repositories/person_repository.dart';
import 'package:rickandmorty_ca_test/domain/usecases/get_all_persons_usecase.dart';
import 'package:rickandmorty_ca_test/domain/usecases/search_for_person_usecase.dart';
import 'package:rickandmorty_ca_test/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rickandmorty_ca_test/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// BLoC, Cubit
  sl.registerFactory(() => PersonListCubit(
        getAllPersonUsecase: sl(),
      ));
  sl.registerFactory(() => SearchBloc(
        searchForPersonUsecase: sl(),
      ));

  /// Usecases
  sl.registerLazySingleton(() => GetAllPersonUsecase(
        personRepository: sl(),
      ));
  sl.registerLazySingleton(() => SearchForPersonUsecase(
        personRepository: sl(),
      ));

  /// Repository
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
        remoteDatasource: sl(),
        localDatasource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<PersonRemoteDatasource>(
      () => PersonRemoteDatasourceImpl(dio: DioSingleton().instance()));

  sl.registerLazySingleton<PersonLocalDatasource>(
      () => PersonLocalDatasourceImpl());

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        connectionChecker: sl(),
      ));

  /// External
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  sl.registerLazySingleton(() => DioSingleton().instance());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
