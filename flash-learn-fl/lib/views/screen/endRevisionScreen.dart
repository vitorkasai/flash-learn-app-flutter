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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Revisão Finalizada',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onBackToDecks,
              child: const Text('Voltar para os Decks'),
            ),
          ],
        ),
      ),
    );
  }
}
