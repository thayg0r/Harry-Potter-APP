import 'package:equatable/equatable.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object?> get props => [];
}

class GetAllCharactersEvent extends CharactersEvent {}

class GetCharactersByHouseEvent extends CharactersEvent {
  final String house;

  const GetCharactersByHouseEvent(this.house);

  @override
  List<Object?> get props => [house];
}
