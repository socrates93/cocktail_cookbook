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
  bool _isLoading = false;
  String selectedCategory = 'Alcoholic';
  List<Drink> _categories = [];
  List<Drink> _drinks = [];
  final _isSelectedList = [true, false];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData(context);
    });
  }

  Future fetchData(BuildContext _) async {
    try {
      setState(() {
        _isLoading = true;
      });

      showDialog(
        context: _,
        barrierDismissible: false,
        builder: (context) => const LoadingDialogWidget(),
      );

      if (_categories.isEmpty) {
        _categories = await drinkService.getCategories();
      }

      _drinks = await drinkService.getFiltered(selectedCategory);

      Navigator.of(_).pop();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      setState(() {
        _isLoading = false;
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
                const SearchInputWidget(),
                _isLoading
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
                                          onPressed: () {},
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
                                  itemCount: _drinks.length,
                                  itemBuilder: (BuildContext _, int index) {
                                    return DrinkCardWidget(
                                      height: device.size.height * 0.3,
                                      drink: _drinks[index],
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
