import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme_provider.dart';
import 'choiceDeckScreen.dart';
import 'manageDecksScreen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _startRevision(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChoiceDeckScreen(
          onNavigateUp: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _manageDecks(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ManageDecksScreen(
          onNavigateUp: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Flash Learn App"),
        actions: [
          IconButton(
            icon: Icon(
                themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    "Bem-vindo ao Flash Learn App, aqui você pode usar flash cards virtuais para estudos e memorização",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/icon.png',
                height: 150,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () => _startRevision(context),
                      child: const Text("Iniciar revisão"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () => _manageDecks(context),
                      child: const Text("Gerenciar pilhas de cartões"),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
