import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Future.microtask(() => Provider.of<ManageDecksViewModel>(context, listen: false).loadDecks());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ManageDecksViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Decks'),
      ),
      body: viewModel.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Gerenciar Decks',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: ListView.builder(
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
                    onTap: () => (),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: widget.onNavigateUp,
          child: const Text('Voltar à Tela Inicial'),
        ),
      ),
    );
  }
}
