import 'package:dio/dio.dart';
import 'package:flashlearnapp_fl/repository/apiRepository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_repository_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late ApiRepository apiRepository;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    apiRepository = ApiRepository(dio: mockDio);
  });

  group('Grupo de testes do getAllDecks', () {
    test('Deve retornar uma lista vazia quando nao tem decks', () async {
      when(mockDio.get('/deck')).thenAnswer((_) async => Response(
        data: [],
        statusCode: 200,
        requestOptions: RequestOptions(path: '/deck'),
      ));

      final decks = await apiRepository.getAllDecks();
      expect(decks, isEmpty);
      verify(mockDio.get('/deck')).called(1);
    });

    test('Deve dar throw em uma exception quando a resposta http não for 200', () async {
      when(mockDio.get('/deck')).thenAnswer((_) async => Response(
        data: 'Error',
        statusCode: 500,
        requestOptions: RequestOptions(path: '/deck'),
      ));

      expect(() async => await apiRepository.getAllDecks(), throwsException);
      verify(mockDio.get('/deck')).called(1);
    });
  });

  group('Grupo de testes do getCardsByCategory', () {
    test('Deve retornar uma lista de cards a partir de uma categoria', () async {
      when(mockDio.get('/card/Category1')).thenAnswer((_) async => Response(
        data: [
          {'id': 1, 'front': 'Front 1', 'back': 'Back 1'},
          {'id': 2, 'front': 'Front 2', 'back': 'Back 2'}
        ],
        statusCode: 200,
        requestOptions: RequestOptions(path: '/card/Category1'),
      ));

      final cards = await apiRepository.getCardsByCategory('Category1');
      expect(cards.length, 2);
      expect(cards.first.front, 'Front 1');
      expect(cards.last.back, 'Back 2');
      verify(mockDio.get('/card/Category1')).called(1);
    });

    test('Deve dar throw em exception em card não encontrado por categoria', () async {
      when(mockDio.get('/card/Category1')).thenAnswer((_) async => Response(
        data: 'Error',
        statusCode: 404,
        requestOptions: RequestOptions(path: '/card/Category1'),
      ));

      expect(() async => await apiRepository.getCardsByCategory('Category1'), throwsException);
      verify(mockDio.get('/card/Category1')).called(1);
    });
  });

  group('Grupo de testes do deleteDeck', () {
    test('Deve deletar um deck com sucesso', () async {
      when(mockDio.delete('/deck/1')).thenAnswer((_) async => Response(
        statusCode: 200,
        requestOptions: RequestOptions(path: '/deck/1'),
      ));

      await apiRepository.deleteDeck(1);
      verify(mockDio.delete('/deck/1')).called(1);
    });

    test('Deve dar throw em exception caso falhe em validar deck existente', () async {
      when(mockDio.delete('/deck/1')).thenAnswer((_) async => Response(
        statusCode: 500,
        requestOptions: RequestOptions(path: '/deck/1'),
      ));

      expect(() async => await apiRepository.deleteDeck(1), throwsException);
      verify(mockDio.delete('/deck/1')).called(1);
    });
  });

  group('Grupo de testes do createDeck', () {
    test('Deve criar um deck com sucesso', () async {
      when(mockDio.post('/deck', data: {'category': 'Category1'})).thenAnswer(
              (_) async => Response(
            statusCode: 201,
            requestOptions: RequestOptions(path: '/deck'),
          ));

      await apiRepository.createDeck('Category1');
      verify(mockDio.post('/deck', data: {'category': 'Category1'})).called(1);
    });

    test('Deve dar throw em exception caso ocorra uma falha na criação de um deck', () async {
      when(mockDio.post('/deck', data: {'category': 'Category1'})).thenAnswer(
              (_) async => Response(
            statusCode: 400,
            requestOptions: RequestOptions(path: '/deck'),
          ));

      expect(() async => await apiRepository.createDeck('Category1'), throwsException);
      verify(mockDio.post('/deck', data: {'category': 'Category1'})).called(1);
    });
  });
}
