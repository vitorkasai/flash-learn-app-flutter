import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/addDeckViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.addDeck),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.categoryDeck,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: loc.category,
                border: const OutlineInputBorder(),
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
                child: Text(loc.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
