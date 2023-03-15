import 'package:ebra_w_5et/routes.dart';
import 'package:ebra_w_5et/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_schemes.g.dart';
import 'screens/home_page_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: const TextTheme(
          headline3: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          subtitle1: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      routes: {
        HomePageScreen.routeName: (context) => const HomePageScreen(),
      },
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _activeRoute = routes['Home']!['route'];

  void _changeTab(label) {
    setState(() {
      _activeRoute = routes[label]!['route'];
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        foregroundColor: const Color(0xFFAE3203),
        title: const Text("Logo"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Color(0xFFAE3203),
            ),
          )
        ],
      ),
      body: _activeRoute,
      bottomNavigationBar: BottomNavBarWidget(
        navigateTo: _changeTab,
        routes: routes,
      ),
    );
  }
}
