import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addCardScreen.dart';
import 'deckDetailViewModel.dart';

class DeckDetailScreen extends StatefulWidget {
  final String deckName;
  final VoidCallback onNavigateUp;

  const DeckDetailScreen({
    Key? key,
    required this.deckName,
    required this.onNavigateUp,
  }) : super(key: key);

  @override
  _DeckDetailScreenState createState() => _DeckDetailScreenState();
}

class _DeckDetailScreenState extends State<DeckDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Carrega os cards com base na categoria ao iniciar a tela
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DeckDetailViewModel>(context, listen: false)
          .loadCardsByCategory(widget.deckName);
    });
  }

  // Método para recarregar os cartões
  void _reloadCards() {
    Provider.of<DeckDetailViewModel>(context, listen: false)
        .loadCardsByCategory(widget.deckName);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DeckDetailViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deckName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: viewModel.isLoading
                  ? const Center(
                      child: CircularProgressIndicator()) // Exibe carregando
                  : ListView.builder(
                      itemCount: viewModel.cardList.length,
                      itemBuilder: (context, index) {
                        final card = viewModel.cardList[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Frente: ${card.front}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Verso: ${card.back}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    // Chama o método para deletar o card
                                    await viewModel.deleteCard(
                                        card.id, widget.deckName);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onNavigateUp,
                    child: const Text('Voltar'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      // Redireciona para AddCardScreen e aguarda o resultado
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddCardScreen(
                            category: widget.deckName,
                            // Passa a categoria do deck
                            onNavigateUp: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      );

                      // Verifica se um cartão foi adicionado e recarrega os cartões
                      if (result == true) {
                        _reloadCards(); // Recarrega os cartões
                      }
                    },
                    child: const Text('Adicionar Cartão'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
