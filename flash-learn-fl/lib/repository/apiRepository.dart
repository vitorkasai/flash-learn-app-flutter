import 'package:dio/dio.dart';
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

  Future<void> deleteDeck(int id) async {
    final response = await _dio.delete('/deck/$id');

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar o deck');
    }
  }
}
