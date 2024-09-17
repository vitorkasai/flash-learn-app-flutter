import 'package:flashlearnapp_fl/repository/card.dart';

class Deck {
  final int id;
  final String category;
  final List<CardDTO> cards;

  Deck({
    required this.id,
    required this.category,
    required this.cards,
  });

  factory Deck.fromJson(Map<String, dynamic> json) {
    var cardsJson = json['cards'] as List;
    List<CardDTO> cardList = cardsJson.map((cardJson) => CardDTO.fromJson(cardJson)).toList();

    return Deck(
      id: json['id'],
      category: json['category'],
      cards: cardList,
    );
  }

  @override
  String toString() {
    return 'Deck(id: $id, category: $category, cards: $cards)';
  }
}
