import 'package:flutter/material.dart';
import 'package:rickandmorty_ca_test/presentation/screens/home/widgets/custom_search_delegate_widget.dart';
import 'package:rickandmorty_ca_test/presentation/screens/home/widgets/person_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
        ],
      ),
      body: PersonListWidget(),
    );
  }
}
