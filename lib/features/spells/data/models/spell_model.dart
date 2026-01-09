import '../../domain/entities/spell.dart';

class SpellModel extends Spell {
  const SpellModel({
    required super.name,
    required super.description,
  });

  factory SpellModel.fromJson(Map<String, dynamic> json) {
    return SpellModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }

  static List<SpellModel> fromJsonList(List<dynamic> list) {
    return list.map((e) => SpellModel.fromJson(e)).toList();
  }
}
