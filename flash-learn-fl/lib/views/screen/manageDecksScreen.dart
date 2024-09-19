import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/manageDecksViewModel.dart';
import 'addDeckScreen.dart';
import 'deckDetailScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final loc = AppLocalizations.of(context)!;


    return Scaffold(
      appBar: AppBar(
        title: Text(loc.manageDecks),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  loc.selectDeck,
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
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DeckDetailScreen(
                                        deckName: deck.category,
                                        onNavigateUp: () {
                                          Navigator.of(context).pop();
                                        }),
                                  ),
                                );
                              },
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
                  child: Text(loc.backToHome),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddDeckScreen(),
                      ),
                    );

                    if (result == true) {
                      Provider.of<ManageDecksViewModel>(context, listen: false)
                          .loadDecks();
                    }
                  },
                  child: Text(loc.addDeck),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
