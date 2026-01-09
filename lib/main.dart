import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_app/features/spells/data/datasources/spells_local_datasource.dart';
import 'package:hp_app/features/spells/domain/repositories/spell_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hp_app/core/theme/app_theme.dart';
import 'package:hp_app/core/dio/dio_client.dart';

import 'features/characters/data/datasources/characters_remote_datasource.dart';
import 'features/characters/data/datasources/characters_local_datasource.dart';
import 'features/characters/data/repositories/character_repository_impl.dart';
import 'features/characters/domain/repositories/character_repository.dart';
import 'features/characters/presentation/bloc/characters_bloc.dart';
import 'features/characters/presentation/bloc/characters_event.dart';
import 'features/characters/presentation/pages/characters_page.dart';

import 'features/spells/data/datasources/spells_remote_datasource.dart';
import 'features/spells/domain/repositories/spell_repository.dart';

import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dioClient = DioClient();
  final prefs = await SharedPreferences.getInstance();

  final charactersRemoteDataSource =
      CharactersRemoteDataSourceImpl(dioClient.dio);

  final charactersLocalDataSource = CharactersLocalDataSourceImpl(prefs);

  final CharacterRepository characterRepository = CharacterRepositoryImpl(
    charactersRemoteDataSource,
    charactersLocalDataSource,
  );

  final spellsRemoteDataSource = SpellsRemoteDataSourceImpl(dioClient.dio);

  final spellsLocalDataSource = SpellsLocalDataSourceImpl(prefs);

  final SpellRepository spellRepository = SpellRepositoryImpl(
    spellsRemoteDataSource,
    spellsLocalDataSource,
  );

  runApp(
    MyApp(
      characterRepository: characterRepository,
      spellRepository: spellRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final CharacterRepository characterRepository;
  final SpellRepository spellRepository;

  const MyApp({
    super.key,
    required this.characterRepository,
    required this.spellRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CharacterRepository>.value(
          value: characterRepository,
        ),
        RepositoryProvider<SpellRepository>.value(
          value: spellRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CharactersBloc(characterRepository)
              ..add(GetAllCharactersEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          title: 'Harry Potter',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: const CharactersPage(),
        ),
      ),
    );
  }
}
