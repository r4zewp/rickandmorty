import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_ca_test/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rickandmorty_ca_test/presentation/bloc/search_bloc/search_event.dart';
import 'package:rickandmorty_ca_test/presentation/bloc/search_bloc/search_state.dart';
import 'package:rickandmorty_ca_test/presentation/screens/home/widgets/search_result.dart';

import '../../../bloc/person_list_cubit/person_list_cubit.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for characters');

  final ScrollController _scrollCtrl = ScrollController();
  bool isLoading = false;
  int page = 1;

  final _suggestions = [
    'Rick',
    'Morty',
    'Rick',
    'Morty',
    'Rick',
    'Morty',
    'Rick',
    'Morty',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      tooltip: 'Return',
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    context
        .read<SearchBloc>()
        .add(SearchButtonPressed(query: query, page: page));
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is PersonSearchLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (state is PersonSearchLoaded) {
          _setupScrollCtrl(context, page);
          final persons = state.persons;
          if (persons.isNotEmpty) {
            return ListView.builder(
              controller: _scrollCtrl,
              itemCount: persons.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                final singlePerson = persons[index];
                return SearchResult(searchResult: singlePerson);
              },
            );
          } else {
            return _showErrorText(errorMessage: 'Nothing found :(');
          }
        } else if (state is PersonSearchError) {
          return _showErrorText(errorMessage: state.errorMessage);
        } else {
          return const Icon(Icons.wallpaper_rounded);
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _suggestions.length,
      itemBuilder: (context, index) => SizedBox(
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _suggestions[index],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Icon(
                  Icons.auto_fix_high_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showErrorText({required String errorMessage}) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _setupScrollCtrl(BuildContext context, int page) {
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.atEdge && _scrollCtrl.position.pixels != 0) {
        context.read<PersonListCubit>().loadPerson();
        page++;
      }
    });
  }
}
