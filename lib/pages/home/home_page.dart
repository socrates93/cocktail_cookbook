import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/repository/drink_service.dart';
import 'package:cocktail_cookbook/shared/widgets/drink_card.dart';
import 'package:cocktail_cookbook/shared/widgets/search_input.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final drinkService = DrinkService();
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: FutureBuilder(
                      future: drinkService.getFiltered('Alcoholic'),
                      builder: (BuildContext _, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext _, int index) {
                              return DrinkCardWidget(
                                height: device.size.height * 0.25,
                                drink: snapshot.data[index],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 4,
                            ),
                          );
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
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
