import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hp_app/features/characters/domain/entities/character.dart';
import 'package:hp_app/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:hp_app/features/characters/presentation/bloc/characters_event.dart';
import 'package:hp_app/features/characters/presentation/bloc/characters_state.dart';
import 'package:hp_app/features/characters/presentation/pages/character_details_page.dart';

import 'package:hp_app/features/spells/presentation/pages/spells_page.dart';
import 'package:hp_app/features/spells/presentation/bloc/spells_bloc.dart';
import 'package:hp_app/features/spells/presentation/bloc/spells_event.dart';
import 'package:hp_app/features/spells/domain/repositories/spell_repository.dart';

import 'package:hp_app/l10n/app_localizations.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  @override
  void initState() {
    super.initState();
    context.read<CharactersBloc>().add(GetAllCharactersEvent());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.characters,
          style: const TextStyle(
            fontFamily: 'HarryP',
            fontSize: 40,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_fix_high),
            tooltip: l10n.spells,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (context) => SpellsBloc(
                      context.read<SpellRepository>(),
                    )..add(GetAllSpellsEvent()),
                    child: const SpellsPage(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const _HouseFilter(),
          Expanded(
            child: BlocBuilder<CharactersBloc, CharactersState>(
              builder: (context, state) {
                if (state is CharactersLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                      strokeWidth: 1,
                    ),
                  );
                }

                if (state is CharactersLoaded) {
                  return _CharactersList(state.characters);
                }

                if (state is CharactersError) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CharactersList extends StatelessWidget {
  final List<Character> characters;

  const _CharactersList(this.characters);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: characters.length,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final character = characters[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CharacterDetailsPage(
                  character: character,
                ),
              ),
            );
          },
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: character.image,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    placeholder: (_, __) => Container(
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                          strokeWidth: 1,
                        ),
                      ),
                    ),
                    errorWidget: (_, __, ___) => const Center(
                      child: Icon(Icons.person, size: 80),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.85),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        character.name,
                        style: const TextStyle(
                          fontFamily: 'HarryP',
                          fontSize: 40,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                      Text(
                        character.house.isEmpty
                            ? l10n.unknownHouse
                            : character.house,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 14,
                          fontFamily: 'sans-serif-medium',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HouseFilter extends StatefulWidget {
  const _HouseFilter();

  @override
  State<_HouseFilter> createState() => _HouseFilterState();
}

class _HouseFilterState extends State<_HouseFilter> {
  late String selectedHouse;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    selectedHouse = l10n.all;
  }

  List<String> get orderedHouses {
    final l10n = AppLocalizations.of(context)!;

    const houses = [
      'Gryffindor',
      'Slytherin',
      'Ravenclaw',
      'Hufflepuff',
    ];

    if (selectedHouse == l10n.all) {
      return [l10n.all, ...houses];
    }

    final reorderedHouses = [
      selectedHouse,
      ...houses.where((h) => h != selectedHouse),
    ];

    return [l10n.all, ...reorderedHouses];
  }

  void _onHouseSelected(String house) {
    final l10n = AppLocalizations.of(context)!;

    setState(() {
      if (house == selectedHouse) {
        selectedHouse = l10n.all;
        context.read<CharactersBloc>().add(GetAllCharactersEvent());
        return;
      }

      selectedHouse = house;

      if (house == l10n.all) {
        context.read<CharactersBloc>().add(GetAllCharactersEvent());
      } else {
        context.read<CharactersBloc>().add(GetCharactersByHouseEvent(house));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final houses = orderedHouses;

    return SizedBox(
      height: 60,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: houses.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          final house = houses[index];
          final isSelected = house == selectedHouse;

          return ChoiceChip(
            showCheckmark: false,
            label: Text(
              house,
              style: TextStyle(
                color: isSelected
                    ? _getHouseBorderColor(house)
                    : Color(0xFF1A1A1A),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            selected: isSelected,
            selectedColor: getHouseColor(house),
            backgroundColor: Colors.grey.shade200,
            shape: StadiumBorder(
              side: BorderSide(
                color: isSelected
                    ? _getHouseBorderColor(house)
                    : const Color(0xFF1A1A1A),
                width: 1,
              ),
            ),
            onSelected: (_) => _onHouseSelected(house),
          );
        },
      ),
    );
  }
}

Color getHouseColor(String house) {
  switch (house.toUpperCase()) {
    case 'GRYFFINDOR':
      return const Color(0xFF740001);
    case 'SLYTHERIN':
      return const Color(0xFF1A472A);
    case 'RAVENCLAW':
      return const Color(0xFF0E1A40);
    case 'HUFFLEPUFF':
      return const Color(0xFFFFDB00);
    default:
      return const Color(0xFFA09697);
  }
}

Color _getHouseBorderColor(String house) {
  switch (house.toUpperCase()) {
    case 'GRYFFINDOR':
      return const Color(0xFFD3A625);
    case 'HUFFLEPUFF':
      return const Color(0xFF000000);
    case 'RAVENCLAW':
      return const Color(0xFF946B2D);
    case 'SLYTHERIN':
      return const Color(0xFFAAAAAA);
    default:
      return Colors.deepPurple;
  }
}
