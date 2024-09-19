import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/addCardViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final loc = AppLocalizations.of(context)!;


    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              loc.addCardDetails,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _frontController,
              decoration: InputDecoration(
                labelText: loc.cardFront,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _backController,
              decoration: InputDecoration(
                labelText: loc.cardBack,
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
                        await addCardViewModel.addCard(
                          front,
                          back,
                          widget.category,
                        );

                        Navigator.of(context).pop(true);
                      }
                    },
                    child: Text(loc.addCard),
                  ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: widget.onNavigateUp,
              child: Text(loc.returnMessage),
            ),
          ],
        ),
      ),
    );
  }
}
