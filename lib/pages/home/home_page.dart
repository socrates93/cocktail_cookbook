import 'package:cocktail_cookbook/shared/widgets/drink_card.dart';
import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/shared/widgets/search_input.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context);

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
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SearchInputWidget(),
                const SizedBox(height: 60),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => DrinkCardWidget(
                      height: device.size.height * 0.25,
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                    itemCount: 5,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
