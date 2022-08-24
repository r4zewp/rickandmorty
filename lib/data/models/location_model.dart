import 'package:rickandmorty_ca_test/domain/entities/location_entity/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({required name, required url}) : super(name: name, url: url);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
