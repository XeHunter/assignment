import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'card.dart';
import '../proj_provider/like_provider.dart';

class Liked extends StatelessWidget {
  const Liked({super.key});

  @override
  Widget build(BuildContext context) {
    final likedCardsProvider = Provider.of<LikedCardsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Cards'),
      ),
      body: ListView.builder(
        itemCount: likedCardsProvider.likedCards.length,
        itemBuilder: (context, index) {
          final card = likedCardsProvider.likedCards[index];
          return CustomCard(
            title: card.title,
            subtitle: card.subtitle,
            imageUrl: card.imageUrl,
            description: card.description,
          );
        },
      ),
    );
  }
}
