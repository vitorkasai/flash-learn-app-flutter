import 'package:flashlearnapp_fl/repository/cardDto.dart';
import 'package:flutter/material.dart';

import 'endRevisionScreen.dart';

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
    if (currentCardIndex >= widget.cards.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EndRevisionScreen(
              onBackToDecks: () =>
                  Navigator.pop(context),
            ),
          ),
        );
      });
      return const SizedBox.shrink();
    }

    final currentCard = widget.cards[currentCardIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Revisão de Cards'),
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
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              if (isBackVisible)
                Text(
                  'Resposta: ${currentCard.back}',
                  style: Theme.of(context).textTheme.headlineSmall,
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
                child: const Text('Virar Cartão'),
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
                child: const Text('Próximo Cartão'),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: widget.onNavigateUp,
          child: const Text('Sair da Revisão'),
        ),
      ),
    );
  }
}
