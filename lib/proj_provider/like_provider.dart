import 'package:flutter/foundation.dart';
import '../models/like_model.dart';

class LikedCardsProvider extends ChangeNotifier {
  final List<LikedCard> _likedCards = [];

  List<LikedCard> get likedCards => _likedCards;

  void addLikedCard(
      String title,
      String subtitle,
      String imageUrl,
      String description,
      ) {
    final card = LikedCard(
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      description: description,
    );

    _likedCards.add(card);
    notifyListeners();
  }

  void removeLikedCard(
      String title,
      String subtitle,
      String imageUrl,
      String description,
      ) {
    final card = LikedCard(
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      description: description,
    );

    _likedCards.remove(card);
    notifyListeners();
  }
}