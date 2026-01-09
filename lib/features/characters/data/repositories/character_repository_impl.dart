import 'package:hp_app/features/characters/data/datasources/characters_local_datasource.dart';

import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/characters_remote_datasource.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharactersRemoteDataSource remoteDataSource;
  final CharactersLocalDataSource localDataSource;

  CharacterRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
  );

  @override
  Future<List<Character>> getCharacters() async {
    try {
      final remoteCharacters = await remoteDataSource.getCharacters();

      await localDataSource.cacheCharacters(remoteCharacters);

      return remoteCharacters;
    } catch (_) {
      return await localDataSource.getCachedCharacters();
    }
  }

  @override
  Future<List<Character>> getCharactersByHouse(String house) async {
    try {
      final remoteCharacters = await remoteDataSource.getCharacters();

      await localDataSource.cacheCharacters(remoteCharacters);

      return remoteCharacters.where((c) => c.house == house).toList();
    } catch (_) {
      final cached = await localDataSource.getCachedCharacters();

      return cached.where((c) => c.house == house).toList();
    }
  }
// troquei
}
