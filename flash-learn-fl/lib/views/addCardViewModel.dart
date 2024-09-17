import 'package:flutter/material.dart';

import '../repository/apiRepository.dart';

class AddCardViewModel extends ChangeNotifier {
  final ApiRepository apiRepository;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  AddCardViewModel(this.apiRepository);

  Future<void> addCard(String front, String back, String category) async {
    try {
      _isLoading = true;
      notifyListeners();

      await apiRepository.addCard(front, back, category);
    } catch (e) {
      print('Erro ao adicionar o cartão: $e');
      throw Exception('Erro ao adicionar o cartão');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
