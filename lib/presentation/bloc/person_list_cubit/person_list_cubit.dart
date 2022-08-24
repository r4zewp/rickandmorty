import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_ca_test/core/constants.dart';
import 'package:rickandmorty_ca_test/core/error/failure.dart';
import 'package:rickandmorty_ca_test/domain/entities/person_entity/person_entity.dart';
import 'package:rickandmorty_ca_test/domain/usecases/get_all_persons_usecase.dart';
import 'package:rickandmorty_ca_test/presentation/bloc/person_list_cubit/person_list_state.dart';

class PersonListCubit extends Cubit<PersonListState> {
  late final GetAllPersonUsecase getAllPersonUsecase;

  PersonListCubit({required this.getAllPersonUsecase})
      : super(const PersonListEmpty());

  int page = 1;

  void loadPerson() async {
    if (state is PersonListLoading) return;

    final currentState = state;
    var oldPerson = <PersonEntity>[];

    if (currentState is PersonListLoaded) {
      oldPerson = currentState.personsList;
    }

    emit(PersonListLoading(oldPersonList: oldPerson, isFirstFetch: page == 1));

    final failureOrPerson =
        await getAllPersonUsecase(PagePersonParams(page: page));

    failureOrPerson.fold(
      (failure) =>
          emit(PersonListError(errorMessage: _failureToMessage(failure))),
      (person) {
        page++;
        final persons = (state as PersonListLoading).oldPersonList;
        persons.addAll(person);
        emit(PersonListLoaded(personsList: persons));
      },
    );
  }

  String _failureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return Constants.serverExceptionMessage;
      case CacheFailure:
        return Constants.cacheExceptionMessage;
      default:
        return Constants.unexpectedExceptionMessage;
    }
  }
}
