import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// To Watch the Main State
import '../main.dart';

// Components
import '../components/BigCard.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            SizedBox(height: 50),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              spacing: 20,
              runAlignment: WrapAlignment.center,
              runSpacing: 20,
              verticalDirection: VerticalDirection.up,
              clipBehavior: Clip.none,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                ElevatedButton.icon(
                  style: ButtonStyle(
                    iconSize: MaterialStateProperty.all(20),
                    elevation: MaterialStateProperty.all(3),
                  ),
                  onPressed: () {
                    appState.toggleFavorite(appState.current);
                  },
                  icon: Icon(icon),
                  label: Text('Favoritar', textScaleFactor: 1.2),
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    iconSize: MaterialStateProperty.all(20),
                    elevation: MaterialStateProperty.all(3),
                  ),
                  onPressed: () {
                    appState.getNext();
                  },
                  icon: Icon(Icons.arrow_right_alt),
                  label: Text('Próximo', textScaleFactor: 1.2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
