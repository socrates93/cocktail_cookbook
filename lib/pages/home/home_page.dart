import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/repository/drink_service.dart';
import 'package:cocktail_cookbook/pages/home/widgets/drink_card.dart';
import 'package:cocktail_cookbook/shared/widgets/search_input.dart';
import 'package:cocktail_cookbook/shared/widgets/loading_dialog.dart';
import 'package:cocktail_cookbook/shared/classes/drink.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final drinkService = DrinkService();
  bool _isLoadingDrinks = false;
  String selectedCategory = 'Alcoholic';
  List<Drink> _categories = [];
  List<Drink> _drinks = [];
  List<Drink> _filteredDrinks = [];
  final _isSelectedList = [true, false];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData(context);
    });
  }

  Future fetchData(BuildContext _, {bool filterByAlcoholic = true}) async {
    try {
      setState(() {
        _isLoadingDrinks = true;
      });

      showDialog(
        context: _,
        barrierDismissible: false,
        builder: (context) => const LoadingDialogWidget(),
      );

      if (_categories.isEmpty) {
        _categories = await drinkService.getCategories();
      }

      final response = await drinkService.getFiltered(selectedCategory,
          identifier: filterByAlcoholic ? 'a' : 'c');

      _drinks = response;
      _filteredDrinks = response;

      Navigator.of(_).pop();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      setState(() {
        _isLoadingDrinks = false;
      });
    }
  }

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
                Align(
                  alignment: Alignment.topRight,
                  child: ToggleButtons(
                    onPressed: (index) {
                      setState(() {
                        for (int i = 0; i < _isSelectedList.length; i++) {
                          _isSelectedList[i] = i == index;
                        }

                        selectedCategory =
                            index == 0 ? 'Alcoholic' : 'Non_Alcoholic';
                      });

                      fetchData(context);
                    },
                    isSelected: _isSelectedList,
                    borderRadius: BorderRadius.circular(20),
                    borderWidth: 3,
                    borderColor: const Color(0xFF391052),
                    selectedBorderColor: Colors.white,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('Alcoholic'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('Non Alcoholic'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SearchInputWidget(
                  onSearch: (searchText) {
                    setState(() {
                      _filteredDrinks = _drinks
                          .where(
                            (drink) => drink.strDrink!
                                .toLowerCase()
                                .contains(searchText.toLowerCase()),
                          )
                          .toList();
                    });
                  },
                ),
                _isLoadingDrinks
                    ? const SizedBox.shrink()
                    : Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              height: device.size.height * 0.05,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(top: 8),
                                children: _categories
                                    .map<Widget>(
                                      (drink) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: ActionChip(
                                          elevation: 5,
                                          onPressed: () {
                                            setState(() {
                                              selectedCategory = drink
                                                  .strCategory!
                                                  .replaceAll(' ', '_');
                                            });

                                            fetchData(context,
                                                filterByAlcoholic: false);
                                          },
                                          avatar: CircleAvatar(
                                            backgroundColor:
                                                const Color(0xFF875B9F),
                                            child: Text(
                                              '${drink.strCategory?[0].toUpperCase() ?? ""}${drink.strCategory?[1].toUpperCase() ?? ""}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          label: Text(drink.strCategory ?? ""),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ListView.separated(
                                  itemCount: _filteredDrinks.length,
                                  itemBuilder: (BuildContext _, int index) {
                                    final drink = _filteredDrinks[index];

                                    return DrinkCardWidget(
                                      height: device.size.height * 0.3,
                                      drink: drink,
                                      onTap: () async {
                                        final drinkDetails = await drinkService
                                            .getById(int.parse(drink.idDrink!));

                                        if (drinkDetails.isEmpty) {
                                          return;
                                        }

                                        Navigator.pushNamed(
                                          context,
                                          'details',
                                          arguments: drinkDetails[0],
                                        );
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 4,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
