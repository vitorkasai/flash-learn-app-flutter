import 'package:flashlearnapp_fl/repository/deck.dart';
import 'package:flutter/foundation.dart';

import '../repository/apiRepository.dart';

class ChoiceDeckViewModel extends ChangeNotifier {
  final ApiRepository apiRepository;
  bool _isLoading = false;
  List<Deck> _decks = [];

  ChoiceDeckViewModel(this.apiRepository);

  bool get isLoading => _isLoading;

  List<Deck> get decks => _decks;

  Future<void> loadDecks() async {
    _setLoading(true);
    try {
      _decks = await apiRepository.getAllDecks();notifyListeners();
    } catch (e) {
      print('Erro ao carregar os decks: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
