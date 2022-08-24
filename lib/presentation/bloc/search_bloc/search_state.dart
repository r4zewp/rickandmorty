import 'package:equatable/equatable.dart';

import '../../../domain/entities/person_entity/person_entity.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class PersonsEmpty extends SearchState {}

class PersonSearchLoading extends SearchState {}

class PersonSearchLoaded extends SearchState {
  final List<PersonEntity> persons;
  const PersonSearchLoaded({required this.persons});

  @override
  List<Object> get props => [persons];
}

class PersonSearchError extends SearchState {
  final String errorMessage;

  const PersonSearchError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
