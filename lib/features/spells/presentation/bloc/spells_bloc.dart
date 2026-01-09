import 'package:flutter_bloc/flutter_bloc.dart';
import 'spells_event.dart';
import 'spells_state.dart';
import '../../domain/repositories/spell_repository.dart';

class SpellsBloc extends Bloc<SpellsEvent, SpellsState> {
  final SpellRepository repository;

  SpellsBloc(this.repository) : super(SpellsInitial()) {
    on<GetAllSpellsEvent>(_onGetAllSpells);
  }

  Future<void> _onGetAllSpells(
    GetAllSpellsEvent event,
    Emitter<SpellsState> emit,
  ) async {
    emit(SpellsLoading());

    try {
      final spells = await repository.getSpells();
      emit(SpellsLoaded(spells));
    } catch (_) {
      emit(const SpellsError('Erro ao carregar magias'));
    }
  }
}
