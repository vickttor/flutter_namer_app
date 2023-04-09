import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favorites = appState.favorites;

    var theme = Theme.of(context);

    var titlePageStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.primary,
      fontWeight: FontWeight.w300,
      fontSize: 34,
    );

    if (appState.favorites.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Não há nenhum par de palavras favorito.',
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
            style: TextStyle(color: theme.colorScheme.onBackground),
          ),
        ),
      );
    }

    return ListView(
      semanticChildCount: favorites.length,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "Você tem ${favorites.length} favoritos.",
            style: titlePageStyle,
          ),
        ),
        for (var fav in favorites)
          ListTile(
            title: Text(fav.asCamelCase),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            leading: IconButton(
              onPressed: () {
                setState(() {
                  favorites.remove(fav);
                });
              },
              icon: Icon(Icons.delete_rounded),
              color: Colors.redAccent,
            ),
            horizontalTitleGap: 10,
          ),
      ],
    );
  }
}
