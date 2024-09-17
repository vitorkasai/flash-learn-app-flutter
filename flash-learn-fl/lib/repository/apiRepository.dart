import 'package:dio/dio.dart';
import 'package:flashlearnapp_fl/repository/cardDto.dart';

import 'deckDto.dart';

class ApiRepository {
  final Dio dio;

  ApiRepository({Dio? dio}) : dio = dio ?? Dio(BaseOptions(baseUrl: "http://10.0.2.2:8080/"));

  Future<List<DeckDTO>> getAllDecks() async {
    final response = await dio.get('/deck');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data as List<dynamic>;
      List<DeckDTO> decks = data.map((deckJson) {
        return DeckDTO.fromJson(deckJson);
      }).toList();
      return decks;
    } else {
      throw Exception('Falha ao carregar decks');
    }
  }

  Future<List<CardDTO>> getCardsByCategory(String category) async {
    final response = await dio.get('/card/$category');

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
    final response = await dio.delete('/deck/$id');

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar o deck');
    }
  }

  Future<void> createDeck(String category) async {
    try {
      final response = await dio.post(
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
      final response = await dio.post(
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

  Future<void> deleteCard(int id) async {
    final response = await dio.delete('/card/$id');

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar o cartão');
    } else {
      print('Cartão excluído com sucesso!');
    }
  }
}
