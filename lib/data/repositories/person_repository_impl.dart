import 'package:rickandmorty_ca_test/core/error/exceptions.dart';
import 'package:rickandmorty_ca_test/core/platform/network_info.dart';
import 'package:rickandmorty_ca_test/data/datasources/person_local_ds/person_local_ds.dart';
import 'package:rickandmorty_ca_test/data/datasources/person_remote_ds/person_remote_ds.dart';
import 'package:rickandmorty_ca_test/data/models/person_model.dart';
import 'package:rickandmorty_ca_test/domain/entities/person_entity/person_entity.dart';
import 'package:rickandmorty_ca_test/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rickandmorty_ca_test/domain/repositories/person_repository.dart';

class PersonRepositoryImpl extends PersonRepository {
  late final PersonLocalDatasource localDatasource;
  late final PersonRemoteDatasource remoteDatasource;
  late final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return _getPersons(() => remoteDatasource.getAllPersons(page));
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchForPerson(
      String query, int page) async {
    return _getPersons(() => remoteDatasource.searchforPerson(query, page));
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDatasource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDatasource.getLastPersonsFromCache();
        return Right(localPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
