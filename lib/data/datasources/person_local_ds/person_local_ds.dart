import 'package:rickandmorty_ca_test/data/models/person_model.dart';

abstract class PersonLocalDatasource {
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}
