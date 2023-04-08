import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  int getFavoriteAmount() {
    return favorites.length;
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    final theme = Theme.of(context);

    final textStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primary,
      fontWeight: FontWeight.bold,
    );

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    LinearGradient backgroundGradient = LinearGradient(
      colors: [Colors.white, theme.colorScheme.primary],
      begin: Alignment.center,
      end: Alignment.bottomCenter,
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BigCard(pair: pair),
              SizedBox(height: 50),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      appState.toggleFavorite();
                    },
                    icon: Icon(
                      icon,
                      size: 18,
                    ),
                    label: Text(
                      "Favoritar",
                      textScaleFactor: 1.2,
                    ),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () {
                      appState.getNext();
                    },
                    child: Text("Próximo", textScaleFactor: 1.2),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                "Favoritos: ${appState.getFavoriteAmount()}",
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.w700,
    );

    LinearGradient cardGradient = LinearGradient(
      colors: [Colors.deepPurpleAccent, theme.colorScheme.primary],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Container(
      decoration: BoxDecoration(
        gradient: cardGradient,
        borderRadius: BorderRadiusDirectional.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asPascalCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
