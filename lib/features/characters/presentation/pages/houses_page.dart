import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/characters_bloc.dart';
import '../bloc/characters_event.dart';
import 'characters_page.dart';

class HousesPage extends StatelessWidget {
  const HousesPage({super.key});

  static const houses = [
    'Gryffindor',
    'Slytherin',
    'Ravenclaw',
    'Hufflepuff',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Casas',
          style: TextStyle(fontFamily: 'HarryP'),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: houses.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final house = houses[index];

          return Card(
            child: ListTile(
              title: Text(
                house,
                style: const TextStyle(fontSize: 18),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                context
                    .read<CharactersBloc>()
                    .add(GetCharactersByHouseEvent(house));

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CharactersPage(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
