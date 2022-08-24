import 'package:rickandmorty_ca_test/data/models/location_model.dart';
import 'package:rickandmorty_ca_test/data/models/origin_model.dart';
import 'package:rickandmorty_ca_test/domain/entities/person_entity/person_entity.dart';

class PersonModel extends PersonEntity {
  PersonModel({
    required id,
    required name,
    required status,
    required species,
    required type,
    required gender,
    required origin,
    required location,
    required image,
    required episodes,
    required created,
  }) : super(
          id: id,
          name: name,
          status: status,
          species: species,
          type: type,
          gender: gender,
          origin: origin,
          location: location,
          image: image,
          episodes: episodes,
          created: created,
        );

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      species: json["species"],
      type: json["type"],
      gender: json["gender"],
      origin:
          json['origin'] != null ? OriginModel.fromJson(json['origin']) : null,
      location: json["location"] != null
          ? LocationModel.fromJson(json['origin'])
          : null,
      image: json['image'],
      episodes: (json['episode'] as List<dynamic>).map((e) {
        return e as String;
      }).toList(),
      created: DateTime.parse(json['created'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin,
      'location': location,
      'image': image,
      'episode': episodes,
      'created': created.toIso8601String(),
    };
  }
}
