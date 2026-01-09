import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_app/l10n/app_localizations.dart';

import '../bloc/spells_bloc.dart';
import '../bloc/spells_state.dart';

class SpellsPage extends StatelessWidget {
  const SpellsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.spells,
          style: const TextStyle(
            fontFamily: 'HarryP',
            fontSize: 40,
          ),
        ),
      ),
      body: BlocBuilder<SpellsBloc, SpellsState>(
        builder: (context, state) {
          if (state is SpellsLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.grey,
              strokeWidth: 1,
            ));
          }

          if (state is SpellsLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.spells.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (_, index) {
                final spell = state.spells[index];
                return _SpellCard(
                  name: spell.name,
                  description: spell.description,
                );
              },
            );
          }

          if (state is SpellsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _SpellCard extends StatelessWidget {
  final String name;
  final String description;

  const _SpellCard({
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_fix_high,
                color: Color(0xFF1A1A1A),
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                  ),
                  Text(
                    description.isEmpty ? l10n.notInformed : description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade700,
                          fontSize: 18,
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
  }
}
