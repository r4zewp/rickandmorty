import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty_ca_test/core/error/failure.dart';
import 'package:rickandmorty_ca_test/core/usecases/usecase.dart';
import 'package:rickandmorty_ca_test/domain/entities/person_entity/person_entity.dart';
import 'package:rickandmorty_ca_test/domain/repositories/person_repository.dart';

class GetAllPersonUsecase
    extends UseCase<List<PersonEntity>, PagePersonParams> {
  late PersonRepository personRepository;

  GetAllPersonUsecase({required this.personRepository});

  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      PagePersonParams params) async {
    return personRepository.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;
  const PagePersonParams({required this.page});

  @override
  List<Object?> get props => [page];
}
