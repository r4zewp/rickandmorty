import 'package:dartz/dartz.dart';
import 'package:rickandmorty_ca_test/core/error/failure.dart';
import 'package:rickandmorty_ca_test/domain/entities/person_entity/person_entity.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);
  Future<Either<Failure, List<PersonEntity>>> searchForPerson(
      String query, int page);
}
