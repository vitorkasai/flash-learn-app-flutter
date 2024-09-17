import 'package:flashlearnapp_fl/repository/apiRepository.dart';
import 'package:flutter/material.dart';

import '../../repository/cardDto.dart';

class DeckDetailViewModel extends ChangeNotifier {
  final ApiRepository apiRepository;
  List<CardDTO> _cardList = [];
  bool _isLoading = false;

  List<CardDTO> get cardList => _cardList;

  bool get isLoading => _isLoading;

  DeckDetailViewModel(this.apiRepository);

  Future<void> loadCardsByCategory(String category) async {
    try {
      _isLoading = true;
      notifyListeners();

      _cardList = await apiRepository.getCardsByCategory(category);
    } catch (e) {
      print('Erro ao carregar os cards: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCard(int id, String category) async {
    try {
      _isLoading = true;
      notifyListeners();

      await apiRepository.deleteCard(id);
      await loadCardsByCategory(category);
    } catch (e) {
      print('Erro ao excluir o cartão: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
