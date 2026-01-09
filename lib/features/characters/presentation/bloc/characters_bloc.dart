import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/character_repository.dart';
import 'characters_event.dart';
import 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharacterRepository repository;

  CharactersBloc(this.repository) : super(CharactersInitial()) {
    on<GetAllCharactersEvent>(_onGetAllCharacters);
    on<GetCharactersByHouseEvent>(_onGetCharactersByHouse);
  }

  Future<void> _onGetAllCharacters(
    GetAllCharactersEvent event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoading());

    try {
      final characters = await repository.getCharacters();
      emit(CharactersLoaded(characters));
    } catch (e) {
      emit(
        const CharactersError(
          'Erro ao carregar personagens',
        ),
      );
    }
  }

  Future<void> _onGetCharactersByHouse(
    GetCharactersByHouseEvent event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoading());

    try {
      final characters = await repository.getCharactersByHouse(event.house);
      emit(CharactersLoaded(characters));
    } catch (e) {
      emit(
        const CharactersError(
          'Erro ao carregar personagens por casa',
        ),
      );
    }
  }
}
