import 'package:flutter/material.dart';

class EndRevisionScreen extends StatelessWidget {
  final VoidCallback onBackToDecks;

  const EndRevisionScreen({
    Key? key,
    required this.onBackToDecks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Revisão Finalizada!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: onBackToDecks,
                child: const Text('Voltar para os Decks'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
