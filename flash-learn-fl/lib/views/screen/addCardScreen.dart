import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/addCardViewModel.dart';

class AddCardScreen extends StatefulWidget {
  final String category;
  final VoidCallback onNavigateUp;

  const AddCardScreen({
    Key? key,
    required this.category,
    required this.onNavigateUp,
  }) : super(key: key);

  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _frontController = TextEditingController();
  final _backController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final addCardViewModel = Provider.of<AddCardViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Cartão'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Instruções: Adicione os detalhes do cartão',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _frontController,
              decoration: const InputDecoration(
                labelText: 'Frente do Cartão',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _backController,
              decoration: const InputDecoration(
                labelText: 'Verso do Cartão',
              ),
            ),
            const SizedBox(height: 16),
            addCardViewModel.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      final front = _frontController.text;
                      final back = _backController.text;

                      if (front.isNotEmpty && back.isNotEmpty) {
                        // Chama o ViewModel para adicionar o cartão
                        await addCardViewModel.addCard(
                          front,
                          back,
                          widget.category, // Passa a categoria do deck
                        );

                        // Volta para a tela anterior e sinaliza que o cartão foi adicionado
                        Navigator.of(context).pop(true);
                      }
                    },
                    child: const Text('Adicionar Cartão'),
                  ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: widget.onNavigateUp,
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
