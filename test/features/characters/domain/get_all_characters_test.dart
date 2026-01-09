import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:hp_app/features/characters/domain/entities/character.dart';
import 'package:hp_app/features/characters/domain/repositories/character_repository.dart';
import 'package:hp_app/features/characters/domain/usecases/get_all_characters.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late GetAllCharacters usecase;
  late MockCharacterRepository repository;

  setUp(() {
    repository = MockCharacterRepository();
    usecase = GetAllCharacters(repository);
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

  test('deve retornar lista de personagens do repositório', () async {
    when(() => repository.getCharacters()).thenAnswer((_) async => characters);

    final result = await usecase();

    expect(result, characters);
    verify(() => repository.getCharacters()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
