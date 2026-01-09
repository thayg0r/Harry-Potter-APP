import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String name;
  final String house;
  final String image;
  final String actor;
  final String species;
  final String gender;
  final String dateOfBirth;
  final int? yearOfBirth;
  final String ancestry;
  final String eyeColour;
  final String hairColour;
  final String patronus;
  final bool alive;

  const Character({
    required this.name,
    required this.house,
    required this.image,
    required this.actor,
    required this.species,
    required this.gender,
    required this.dateOfBirth,
    required this.yearOfBirth,
    required this.ancestry,
    required this.eyeColour,
    required this.hairColour,
    required this.patronus,
    required this.alive,
  });

  @override
  List<Object?> get props => [
        name,
        house,
        image,
        actor,
        species,
        gender,
        dateOfBirth,
        yearOfBirth,
        ancestry,
        eyeColour,
        hairColour,
        patronus,
        alive,
      ];
}
