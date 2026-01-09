import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character_model.dart';

abstract class CharactersLocalDataSource {
  Future<void> cacheCharacters(List<CharacterModel> characters);
  Future<List<CharacterModel>> getCachedCharacters();
}

class CharactersLocalDataSourceImpl implements CharactersLocalDataSource {
  static const _cacheKey = 'CACHED_CHARACTERS';

  final SharedPreferences prefs;

  CharactersLocalDataSourceImpl(this.prefs);

  @override
  Future<void> cacheCharacters(List<CharacterModel> characters) async {
    final jsonList = characters.map((e) => e.toJson()).toList();

    await prefs.setString(_cacheKey, jsonEncode(jsonList));
  }

  @override
  Future<List<CharacterModel>> getCachedCharacters() async {
    final jsonString = prefs.getString(_cacheKey);

    if (jsonString == null) {
      throw Exception('No cache found');
    }

    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => CharacterModel.fromJson(e)).toList();
  }
}
