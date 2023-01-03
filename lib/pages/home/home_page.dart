import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/shared/widgets/search_input.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF875B9F),
              Color(0xFF391052),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: const [
              SearchInputWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
