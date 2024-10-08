import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/deckDetailViewModel.dart';
import 'addCardScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DeckDetailViewModel>(context, listen: false)
          .loadCardsByCategory(widget.deckName);
    });
  }

  void _reloadCards() {
    Provider.of<DeckDetailViewModel>(context, listen: false)
        .loadCardsByCategory(widget.deckName);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DeckDetailViewModel>(context);
    final loc = AppLocalizations.of(context)!;

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
                      child: CircularProgressIndicator())
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
                                        '${loc.front}: ${card.front}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${loc.back}: ${card.back}',
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
                    child: Text(loc.returnMessage),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddCardScreen(
                            category: widget.deckName,
                            onNavigateUp: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      );

                      if (result == true) {
                        _reloadCards();
                      }
                    },
                    child: Text(loc.addCard),
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
