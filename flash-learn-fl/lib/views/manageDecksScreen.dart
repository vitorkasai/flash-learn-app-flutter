import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addDeckScreen.dart';
import 'manageDecksViewModel.dart';

class ManageDecksScreen extends StatefulWidget {
  final VoidCallback onNavigateUp;

  const ManageDecksScreen({
    Key? key,
    required this.onNavigateUp,
  }) : super(key: key);

  @override
  _ManageDecksScreenState createState() => _ManageDecksScreenState();
}

class _ManageDecksScreenState extends State<ManageDecksScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        Provider.of<ManageDecksViewModel>(context, listen: false).loadDecks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ManageDecksViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Decks'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Gerenciar Decks',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Expanded(
                child: viewModel.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: viewModel.decks.length,
                        itemBuilder: (context, index) {
                          final deck = viewModel.decks[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: ListTile(
                              title: Text(deck.category),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  viewModel.deleteDeck(deck.id);
                                },
                              ),
                              onTap: () => {},
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: widget.onNavigateUp,
                  child: const Text('Voltar à Tela Inicial'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Navega para a tela de adicionar deck e aguarda o resultado
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddDeckScreen(),
                      ),
                    );

                    // Verifica se o resultado foi sucesso (true) e recarrega os decks
                    if (result == true) {
                      Provider.of<ManageDecksViewModel>(context, listen: false)
                          .loadDecks();
                    }
                  },
                  child: const Text('Adicionar Deck'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
