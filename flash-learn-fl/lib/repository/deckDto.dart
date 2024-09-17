import 'package:flashlearnapp_fl/repository/cardDto.dart';

class DeckDTO {
  final int id;
  final String category;
  final List<CardDTO> cards;

  DeckDTO({
    required this.id,
    required this.category,
    required this.cards,
  });

  factory DeckDTO.fromJson(Map<String, dynamic> json) {
    var cardsJson = json['cards'] as List;
    List<CardDTO> cardList = cardsJson.map((cardJson) => CardDTO.fromJson(cardJson)).toList();

    return DeckDTO(
      id: json['id'],
      category: json['category'],
      cards: cardList,
    );
  }

  @override
  String toString() {
    return 'DeckDTO(id: $id, category: $category, cards: $cards)';
  }
}
