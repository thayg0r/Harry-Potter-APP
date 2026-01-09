import 'package:hp_app/features/spells/data/datasources/spells_local_datasource.dart';
import 'package:hp_app/features/spells/data/datasources/spells_remote_datasource.dart';

import '../../domain/entities/spell.dart';
import '../../domain/repositories/spell_repository.dart';

class SpellRepositoryImpl implements SpellRepository {
  final SpellsRemoteDataSource remoteDataSource;
  final SpellsLocalDataSource localDataSource;

  SpellRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
  );

  @override
  Future<List<Spell>> getSpells() async {
    try {
      final spells = await remoteDataSource.getSpells();
      await localDataSource.cacheSpells(spells);
      return spells;
    } catch (_) {
      return await localDataSource.getCachedSpells();
    }
  }
}
