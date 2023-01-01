import 'package:dictionary_game/screens/settings_page.dart';
import 'package:dictionary_game/screens/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => UnscrambleApp(),
        '/settings': (context) => SettingsPage(),
      },
    ),
  );
}