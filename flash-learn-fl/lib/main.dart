import 'package:flashlearnapp_fl/repository/apiRepository.dart';
import 'package:flashlearnapp_fl/views/screen/mainScreen.dart';
import 'package:flashlearnapp_fl/views/viewmodel/addCardViewModel.dart';
import 'package:flashlearnapp_fl/views/viewmodel/addDeckViewModel.dart';
import 'package:flashlearnapp_fl/views/viewmodel/choiceDeckViewModel.dart';
import 'package:flashlearnapp_fl/views/viewmodel/deckDetailViewModel.dart';
import 'package:flashlearnapp_fl/views/viewmodel/manageDecksViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiRepository = ApiRepository();

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ChoiceDeckViewModel(apiRepository)),
          ChangeNotifierProvider(create: (_) => ManageDecksViewModel(apiRepository)),
          ChangeNotifierProvider(create: (_) => AddDeckViewModel(apiRepository)),
          ChangeNotifierProvider(create: (_) => DeckDetailViewModel(apiRepository)),
          ChangeNotifierProvider(create: (_) => AddCardViewModel(apiRepository)),
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Learn App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}