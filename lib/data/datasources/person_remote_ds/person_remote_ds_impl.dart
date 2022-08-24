import 'package:dio/dio.dart';
import 'package:rickandmorty_ca_test/core/dio/endpoints.dart';
import 'package:rickandmorty_ca_test/core/error/exceptions.dart';
import 'package:rickandmorty_ca_test/data/datasources/person_remote_ds/person_remote_ds.dart';
import 'package:rickandmorty_ca_test/data/models/person_model.dart';

class PersonRemoteDatasourceImpl implements PersonRemoteDatasource {
  late Dio _dio;

  PersonRemoteDatasourceImpl({required Dio dio}) {
    _dio = dio;
  }

  @override
  Future<List<PersonModel>> getAllPersons(int page) async =>
      _getPersonFromApi(Endpoints.characterToGet, {'page': page});

  @override
  Future<List<PersonModel>> searchforPerson(String query, int page) async =>
      _getPersonFromApi(Endpoints.characterToGet, {
        'name': query,
        'page': page,
      });

  Future<List<PersonModel>> _getPersonFromApi(
      String url, Map<String, dynamic> queryParams) async {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          handler.next(response);
        },
      ),
    );

    final response = await _dio.get(
      url,
      queryParameters: queryParams,
    );

    if (response.statusCode == 200) {
      return (response.data['results'] as List)
          .map((e) => PersonModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
