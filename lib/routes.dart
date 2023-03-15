import 'package:ebra_w_5et/screens/home_page_screen.dart';
import 'package:flutter/material.dart';

Map<String, dynamic> routes = {
  'Home': <String, dynamic>{
    'icon': Icons.home_outlined,
    'active': false,
    'route': const HomePageScreen(),
  },
  'Favorites': <String, dynamic>{
    'icon': Icons.favorite_border_outlined,
    'active': false,
  },
  'Cart': <String, dynamic>{
    'icon': Icons.shopping_cart_outlined,
    'active': false,
  },
  'Profile': <String, dynamic>{
    'icon': Icons.person_outline,
    'active': false,
  },
};
