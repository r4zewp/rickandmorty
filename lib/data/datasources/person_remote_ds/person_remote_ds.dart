import 'package:rickandmorty_ca_test/data/models/person_model.dart';

abstract class PersonRemoteDatasource {
  Future<List<PersonModel>> getAllPersons(int page);
  Future<List<PersonModel>> searchforPerson(String query, int page);
}
