import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hp_app/l10n/app_localizations.dart';

import '../../domain/entities/character.dart';

class CharacterDetailsPage extends StatelessWidget {
  final Character character;

  const CharacterDetailsPage({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: CustomScrollView(
        slivers: [
          _CharacterAppBar(character),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -6),
              child: _CharacterInfoCard(character),
            ),
          ),
        ],
      ),
    );
  }
}

class _CharacterAppBar extends StatelessWidget {
  final Character character;

  const _CharacterAppBar(this.character);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 360,
      pinned: true,
      backgroundColor: Colors.black,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name,
          style: const TextStyle(
            fontFamily: 'HarryP',
            fontSize: 40,
            color: Colors.white,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: character.image,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorWidget: (_, __, ___) => const Icon(Icons.person, size: 120),
            ),
            Container(
              decoration: BoxDecoration(
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
          ],
        ),
      ),
    );
  }
}

class _CharacterInfoCard extends StatelessWidget {
  final Character character;

  Widget _buildInfoIfNotEmpty({
    required IconData icon,
    required String label,
    required String value,
  }) {
    if (value.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        _InfoRow(
          icon: icon,
          label: label,
          value: value,
        ),
        const Divider(height: 32),
      ],
    );
  }

  const _CharacterInfoCard(this.character);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 42),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InfoRow(
                icon: Icons.person,
                label: l10n.name,
                value: character.name,
              ),
              const Divider(height: 32),
              _buildInfoIfNotEmpty(
                icon: Icons.shield,
                label: l10n.house,
                value: character.house,
              ),
              _buildInfoIfNotEmpty(
                icon: Icons.movie,
                label: l10n.actor,
                value: character.actor,
              ),
              _buildInfoIfNotEmpty(
                icon: Icons.auto_awesome,
                label: l10n.species,
                value: character.species,
              ),
              _buildInfoIfNotEmpty(
                icon: Icons.favorite,
                label: l10n.patronus,
                value: character.patronus,
              ),
              _buildInfoIfNotEmpty(
                icon: Icons.remove_red_eye,
                label: l10n.eyeColour,
                value: character.eyeColour,
              ),
              _buildInfoIfNotEmpty(
                icon: Icons.face,
                label: l10n.hairColour,
                value: character.hairColour,
              ),
              _buildInfoIfNotEmpty(
                icon: Icons.cake,
                label: l10n.dateOfBirth,
                value: character.dateOfBirth,
              ),
              _InfoRow(
                icon: Icons.favorite_border,
                label: l10n.alive,
                value: character.alive ? 'Yes' : 'No',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 28,
          color: Colors.grey.shade500,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.grey.shade600,
                      fontFamily: 'sans-serif-medium',
                      fontSize: 12,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
