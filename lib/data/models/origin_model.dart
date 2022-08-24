import 'package:rickandmorty_ca_test/domain/entities/origin_entity/origin_entity.dart';

class OriginModel extends OriginEntity {
  OriginModel({required name, required url}) : super(name: name, url: url);

  factory OriginModel.fromJson(Map<String, dynamic> json) {
    return OriginModel(name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
