import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:hp_app/features/characters/domain/entities/character.dart';
import 'package:hp_app/features/characters/domain/repositories/character_repository.dart';
import 'package:hp_app/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:hp_app/features/characters/presentation/bloc/characters_event.dart';
import 'package:hp_app/features/characters/presentation/bloc/characters_state.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late CharactersBloc bloc;
  late MockCharacterRepository repository;

  setUp(() {
    repository = MockCharacterRepository();
    bloc = CharactersBloc(repository);
  });

  final characters = [
    Character(
      name: 'Harry Potter',
      house: 'Gryffindor',
      image: 'image_url',
      actor: 'Daniel Radcliffe',
      species: 'human',
      gender: 'male',
      dateOfBirth: '31-07-1980',
      yearOfBirth: 1980,
      ancestry: 'half-blood',
      eyeColour: 'green',
      hairColour: 'black',
      patronus: 'stag',
      alive: true,
    ),
  ];

  blocTest<CharactersBloc, CharactersState>(
    'emite [Loading, Loaded] ao buscar todos os personagens',
    build: () {
      when(() => repository.getCharacters())
          .thenAnswer((_) async => characters);
      return bloc;
    },
    act: (bloc) => bloc.add(GetAllCharactersEvent()),
    expect: () => [
      CharactersLoading(),
      CharactersLoaded(characters),
    ],
    verify: (_) {
      verify(() => repository.getCharacters()).called(1);
    },
  );
}
