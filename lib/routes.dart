import './screens/favorites_screen.dart';
import './screens/home_page_screen.dart';
import './screens/my_cart_screen.dart';
import 'package:flutter/material.dart';

import 'screens/my_profile_screen.dart';

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
    'route': const FavoritesScreen(),
  },
  'Cart': <String, dynamic>{
    'icon': Icons.shopping_cart_outlined,
    'active': false,
    'route': const MyCartScreen(),
  },
  'Profile': <String, dynamic>{
    'icon': Icons.person_outline,
    'active': false,
    'route': const ProfileScreen(),
  },
};
