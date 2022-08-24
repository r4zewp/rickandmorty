import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty_ca_test/core/error/failure.dart';
import 'package:rickandmorty_ca_test/core/usecases/usecase.dart';
import 'package:rickandmorty_ca_test/domain/entities/person_entity/person_entity.dart';
import 'package:rickandmorty_ca_test/domain/repositories/person_repository.dart';

class SearchForPersonUsecase
    extends UseCase<List<PersonEntity>, SearchForPersonQueryParams> {
  late PersonRepository _personRepository;

  SearchForPersonUsecase({required PersonRepository personRepository}) {
    _personRepository = personRepository;
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      SearchForPersonQueryParams params) async {
    return _personRepository.searchForPerson(params.query, params.page);
  }
}

class SearchForPersonQueryParams extends Equatable {
  String query;
  int page;

  SearchForPersonQueryParams({required this.query, required this.page});

  @override
  List<Object> get props => [query];
}
