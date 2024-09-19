import 'package:flashlearnapp_fl/repository/cardDto.dart';
import 'package:flutter/material.dart';

import 'endRevisionScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CardsRevisionScreen extends StatefulWidget {
  final List<CardDTO> cards;
  final VoidCallback onNavigateUp;

  const CardsRevisionScreen({
    Key? key,
    required this.cards,
    required this.onNavigateUp,
  }) : super(key: key);

  @override
  _CardsRevisionScreenState createState() => _CardsRevisionScreenState();
}

class _CardsRevisionScreenState extends State<CardsRevisionScreen> {
  int currentCardIndex = 0;
  bool isBackVisible = false;
  bool isNextEnabled = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    if (currentCardIndex >= widget.cards.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EndRevisionScreen(
              onBackToDecks: () => Navigator.pop(context),
            ),
          ),
        );
      });
      return const SizedBox.shrink();
    }

    final currentCard = widget.cards[currentCardIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.revisingCards),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentCard.front,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (isBackVisible)
                Text(
                  '${loc.back}: ${currentCard.back}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isBackVisible = !isBackVisible;
                    isNextEnabled = true;
                  });
                },
                child: Text(loc.flipCard),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isNextEnabled
                    ? () {
                  if (currentCardIndex < widget.cards.length - 1) {
                    setState(() {
                      currentCardIndex++;
                      isBackVisible = false;
                      isNextEnabled = false;
                    });
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EndRevisionScreen(
                          onBackToDecks: () => Navigator.pop(context),
                        ),
                      ),
                    );
                  }
                }
                    : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.disabled)) {
                        return null;
                      }
                      return Colors.deepPurple;
                    },
                  ),
                ),
                child: Text(
                  loc.nextCard,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: widget.onNavigateUp,
          child: Text(
            loc.leaveRevision,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
