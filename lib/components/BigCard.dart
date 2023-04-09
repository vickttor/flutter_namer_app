// ignore_for_file: file_names
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.w600,
    );

    LinearGradient cardGradient = LinearGradient(
      colors: [Colors.deepPurpleAccent, theme.colorScheme.primary],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Container(
      width: 300,
      alignment: Alignment.center,
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
