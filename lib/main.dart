import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/shared/utils/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoockTail Bar',
      routes: routes,
      initialRoute: 'home',
    );
  }
}
