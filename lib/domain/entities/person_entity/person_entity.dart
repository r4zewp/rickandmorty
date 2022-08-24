import 'package:equatable/equatable.dart';
import 'package:rickandmorty_ca_test/domain/entities/location_entity/location_entity.dart';
import 'package:rickandmorty_ca_test/domain/entities/origin_entity/origin_entity.dart';

class PersonEntity extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final OriginEntity origin;
  final LocationEntity location;
  final String image;
  final List<String> episodes;
  final DateTime created;

  PersonEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episodes,
    required this.created,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episodes,
        created,
      ];
}
