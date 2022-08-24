import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_ca_test/common/colors.dart';
import 'package:rickandmorty_ca_test/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rickandmorty_ca_test/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rickandmorty_ca_test/presentation/screens/home/home_page.dart';
import 'package:rickandmorty_ca_test/service_locator.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(
            create: (context) => sl<PersonListCubit>()..loadPerson()),
        BlocProvider<SearchBloc>(create: (context) => sl<SearchBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        home: const HomePage(),
      ),
    );
  }
}
