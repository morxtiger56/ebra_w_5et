import 'package:ebra_w_5et/screens/favorites_screen.dart';
import 'package:ebra_w_5et/screens/home_page_screen.dart';
import 'package:ebra_w_5et/screens/my_cart_screen.dart';
import 'package:flutter/material.dart';

//TODO: add app headers

Map<String, dynamic> routes = {
  'Home': <String, dynamic>{
    'icon': Icons.home_outlined,
    'active': false,
    'route': const HomePageScreen(),
  },
  'Favorites': <String, dynamic>{
    'icon': Icons.favorite_border_outlined,
    'active': false,
    'route': FavoritesScreen(),
  },
  'Cart': <String, dynamic>{
    'icon': Icons.shopping_cart_outlined,
    'active': false,
    'route': MyCartScreen(),
  },
  'Profile': <String, dynamic>{
    'icon': Icons.person_outline,
    'active': false,
  },
};
