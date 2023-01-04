import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/pages/home/home_page.dart';
import 'package:cocktail_cookbook/pages/details/details_page.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  'home': (BuildContext _) => const HomePageWidget(),
  'details': (BuildContext _) => const DetailsPageWidget(),
};
