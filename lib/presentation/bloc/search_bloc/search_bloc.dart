import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_ca_test/core/constants.dart';
import 'package:rickandmorty_ca_test/core/error/failure.dart';
import 'package:rickandmorty_ca_test/domain/usecases/search_for_person_usecase.dart';
import 'package:rickandmorty_ca_test/presentation/bloc/search_bloc/search_event.dart';
import 'package:rickandmorty_ca_test/presentation/bloc/search_bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchForPersonUsecase searchForPersonUsecase;

  SearchBloc({required this.searchForPersonUsecase}) : super(PersonsEmpty()) {
    on<SearchButtonPressed>(
      (event, emit) async {
        emit(PersonSearchLoading());
        final failureOrPerson = await searchForPersonUsecase(
            SearchForPersonQueryParams(query: event.query, page: event.page));

        print(event.page);
        failureOrPerson.fold(
          (failure) {
            emit(PersonSearchError(errorMessage: _failureToMessage(failure)));
          },
          (persons) => emit(
            PersonSearchLoaded(persons: persons),
          ),
        );
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
