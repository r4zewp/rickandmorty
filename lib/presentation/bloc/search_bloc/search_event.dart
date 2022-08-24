import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchButtonPressed extends SearchEvent {
  final String query;
  final int page;
  const SearchButtonPressed({required this.query, required this.page});
}
