import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_classic/src/pages/home_page.dart';
import 'package:app_classic/src/theme/theme.dart';

void main() => runApp(
  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeChanger(3)),
      ],
      child: const MyApp(),
    ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return MaterialApp(
      theme: currentTheme,
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const HomePage()
    );
  }
}