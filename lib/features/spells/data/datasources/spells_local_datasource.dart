import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/spell_model.dart';

abstract class SpellsLocalDataSource {
  Future<void> cacheSpells(List<SpellModel> spells);
  Future<List<SpellModel>> getCachedSpells();
}

class SpellsLocalDataSourceImpl implements SpellsLocalDataSource {
  static const _cacheKey = 'CACHED_SPELLS';

  final SharedPreferences prefs;

  SpellsLocalDataSourceImpl(this.prefs);

  @override
  Future<void> cacheSpells(List<SpellModel> spells) async {
    final jsonList = spells.map((e) => e.toJson()).toList();
    await prefs.setString(_cacheKey, jsonEncode(jsonList));
  }

  @override
  Future<List<SpellModel>> getCachedSpells() async {
    final jsonString = prefs.getString(_cacheKey);
    if (jsonString == null) throw Exception('No spells cache');

    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => SpellModel.fromJson(e)).toList();
  }
}
