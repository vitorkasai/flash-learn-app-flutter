import 'package:flashlearnapp_fl/repository/apiRepository.dart';
import 'package:flashlearnapp_fl/views/screen/mainScreen.dart';
import 'package:flashlearnapp_fl/views/theme_provider.dart';
import 'package:flashlearnapp_fl/views/viewmodel/addCardViewModel.dart';
import 'package:flashlearnapp_fl/views/viewmodel/addDeckViewModel.dart';
import 'package:flashlearnapp_fl/views/viewmodel/choiceDeckViewModel.dart';
import 'package:flashlearnapp_fl/views/viewmodel/deckDetailViewModel.dart';
import 'package:flashlearnapp_fl/views/viewmodel/manageDecksViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flash Learn App',
      theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MainScreen(),
    );
  }
}
