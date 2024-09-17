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

  // Método para carregar os cards a partir da categoria
  Future<void> loadCardsByCategory(String category) async {
    try {
      _isLoading = true;
      notifyListeners(); // Notifica o estado de carregamento

      // Chama o repositório para buscar os cards pela categoria
      _cardList = await apiRepository.getCardsByCategory(category);
    } catch (e) {
      // Em caso de erro, você pode lidar aqui (mostrar uma mensagem de erro, por exemplo)
      print('Erro ao carregar os cards: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notifica o estado após carregamento
    }
  }

  // Novo método para excluir um cartão
  Future<void> deleteCard(int id, String category) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Chama o repositório para excluir o cartão
      await apiRepository.deleteCard(id);

      // Recarrega os cartões após a exclusão
      await loadCardsByCategory(category);
    } catch (e) {
      print('Erro ao excluir o cartão: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
