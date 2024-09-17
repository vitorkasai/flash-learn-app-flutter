import 'package:flutter/material.dart';

import '../repository/apiRepository.dart';

class AddDeckViewModel extends ChangeNotifier {
  final ApiRepository _apiRepository;

  AddDeckViewModel(this._apiRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> addDeck(String category) async {
    if (category.isEmpty) {
      throw Exception("A categoria não pode estar vazia");
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _apiRepository.createDeck(category);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Erro ao adicionar deck: $e');
    }
  }
}
