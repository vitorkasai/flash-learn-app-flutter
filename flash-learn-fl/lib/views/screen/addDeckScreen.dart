import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/addDeckViewModel.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informe a categoria do deck',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Categoria',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  category = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await addDeckViewModel.addDeck(category);
                  Navigator.pop(context, true);
                },
                child: const Text('Adicionar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
