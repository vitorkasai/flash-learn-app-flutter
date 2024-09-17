import 'package:dio/dio.dart';
import 'package:flashlearnapp_fl/repository/card.dart';

import 'deck.dart';

class ApiRepository {
  final _dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:8080/"));

  Future<List<Deck>> getAllDecks() async {
    final response = await _dio.get('/deck');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data as List<dynamic>;
      List<Deck> decks = data.map((deckJson) {
        return Deck.fromJson(deckJson);
      }).toList();
      return decks;
    } else {
      throw Exception('Falha ao carregar decks');
    }
  }

  Future<List<CardDTO>> getCardsByCategory(String category) async {
    final response = await _dio.get('/card/$category');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data as List<dynamic>;
      List<CardDTO> cards = data.map((cardJson) {
        return CardDTO.fromJson(cardJson);
      }).toList();
      return cards;
    } else {
      throw Exception('Falha ao carregar cards');
    }
  }

  Future<void> deleteDeck(int id) async {
    final response = await _dio.delete('/deck/$id');

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar o deck');
    }
  }

  Future<void> createDeck(String category) async {
    try {
      final response = await _dio.post(
        '/deck',
        data: {
          'category': category,
        },
      );

      if (response.statusCode == 201) {
        print('Deck criado com sucesso!');
      } else {
        throw Exception('Falha ao criar o deck');
      }
    } catch (e) {
      throw Exception('Erro ao criar o deck: $e');
    }
  }

  Future<void> addCard(String front, String back, String deckCategory) async {
    try {
      final response = await _dio.post(
        '/card',
        data: {
          'front': front,
          'back': back,
          'deckCategory': deckCategory,
        },
      );

      if (response.statusCode == 201) {
        print('Cartão criado com sucesso!');
      } else {
        throw Exception('Falha ao criar o cartão');
      }
    } catch (e) {
      throw Exception('Erro ao criar o cartão: $e');
    }
  }
}
