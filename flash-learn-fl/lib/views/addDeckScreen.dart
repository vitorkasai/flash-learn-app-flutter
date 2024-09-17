import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addDeckViewModel.dart';

class AddDeckScreen extends StatefulWidget {
  const AddDeckScreen({Key? key}) : super(key: key);

  @override
  _AddDeckScreenState createState() => _AddDeckScreenState();
}

class _AddDeckScreenState extends State<AddDeckScreen> {
  String category = '';

  @override
  Widget build(BuildContext context) {
    final addDeckViewModel = Provider.of<AddDeckViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Deck'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Adicionar Deck',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Categoria',
              ),
              onChanged: (value) {
                setState(() {
                  category = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Adiciona o deck
                    await addDeckViewModel.addDeck(category);

                    // Redireciona e passa um resultado de sucesso
                    Navigator.pop(context, true);
                  },
                  child: const Text('Adicionar'),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
