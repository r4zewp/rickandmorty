import 'dart:convert';

import 'package:rickandmorty_ca_test/core/env.dart';
import 'package:rickandmorty_ca_test/core/error/exceptions.dart';
import 'package:rickandmorty_ca_test/data/datasources/person_local_ds/person_local_ds.dart';
import 'package:rickandmorty_ca_test/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonLocalDatasourceImpl extends PersonLocalDatasource {
  @override
  Future<List<PersonModel>> getLastPersonsFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonPersonsList = prefs.getStringList(cachedPersonsListkey);

    if (jsonPersonsList != null) {
      return Future.value(
        jsonPersonsList
            .map((e) => PersonModel.fromJson(jsonDecode(e)))
            .toList(),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> personsJson =
        persons.map((e) => jsonEncode(e.toJson())).toList();
    prefs.setStringList(cachedPersonsListkey, personsJson);
    // ignore: void_checks
    return Future.value(personsJson);
  }
}
