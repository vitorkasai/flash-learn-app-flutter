import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/choiceDeckViewModel.dart';
import 'cardsRevisionScreen.dart';

class ChoiceDeckScreen extends StatelessWidget {
  final VoidCallback onNavigateUp;

  ChoiceDeckScreen({
    required this.onNavigateUp,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChoiceDeckViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.loadDecks();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha seu Deck'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Card Decks',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              child: Consumer<ChoiceDeckViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (viewModel.decks.isEmpty) {
                    return const Center(
                      child: Text('Nenhum deck disponível no momento.'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: viewModel.decks.length,
                      itemBuilder: (context, index) {
                        final deck = viewModel.decks[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CardsRevisionScreen(
                                    cards: deck.cards,
                                    onNavigateUp: () => Navigator.pop(
                                        context),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  deck.category,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: onNavigateUp,
                child: const Text('Voltar para a tela inicial'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
