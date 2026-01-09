import '../../domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.name,
    required super.house,
    required super.image,
    required super.actor,
    required super.species,
    required super.gender,
    required super.dateOfBirth,
    required super.yearOfBirth,
    required super.ancestry,
    required super.eyeColour,
    required super.hairColour,
    required super.patronus,
    required super.alive,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      name: json['name'] ?? '',
      house: json['house'] ?? '',
      image: json['image'] ?? '',
      actor: json['actor'] ?? '',
      species: json['species'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      yearOfBirth: json['yearOfBirth'],
      ancestry: json['ancestry'] ?? '',
      eyeColour: json['eyeColour'] ?? '',
      hairColour: json['hairColour'] ?? '',
      patronus: json['patronus'] ?? '',
      alive: json['alive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'house': house,
      'image': image,
      'actor': actor,
      'species': species,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'yearOfBirth': yearOfBirth,
      'ancestry': ancestry,
      'eyeColour': eyeColour,
      'hairColour': hairColour,
      'patronus': patronus,
      'alive': alive,
    };
  }

  static List<CharacterModel> fromJsonList(List<dynamic> list) {
    return list.map((e) => CharacterModel.fromJson(e)).toList();
  }
}
