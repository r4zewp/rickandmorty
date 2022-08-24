import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_ca_test/domain/entities/person_entity/person_entity.dart';
import 'package:rickandmorty_ca_test/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rickandmorty_ca_test/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:rickandmorty_ca_test/presentation/screens/home/widgets/person_card_widget.dart';

class PersonListWidget extends StatelessWidget {
  PersonListWidget({Key? key}) : super(key: key);

  final ScrollController _scrollCtrl = ScrollController();

  void _setupScrollCtrl(BuildContext context) {
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.atEdge && _scrollCtrl.position.pixels != 0) {
        context.read<PersonListCubit>().loadPerson();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupScrollCtrl(context);

    return BlocBuilder<PersonListCubit, PersonListState>(
      builder: (context, state) {
        bool isLoading = false;
        List<PersonEntity> persons = [];
        if (state is PersonListLoading && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonListLoading) {
          persons = state.oldPersonList;
          isLoading = true;
        } else if (state is PersonListLoaded) {
          persons = state.personsList;
        }
        if (state is PersonListError) {
          return Text(state.errorMessage);
        }
        return ListView.separated(
          controller: _scrollCtrl,
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.grey,
            );
          },
          itemCount: persons.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < persons.length) {
              return PersonCardWidget(
                person: persons[index],
              );
            } else {
              Timer(const Duration(milliseconds: 30), () {
                _scrollCtrl.jumpTo(_scrollCtrl.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
