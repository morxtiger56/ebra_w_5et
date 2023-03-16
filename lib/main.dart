import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ebra_w_5et/routes.dart';
import 'package:ebra_w_5et/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_schemes.g.dart';
import 'screens/home_page_screen.dart';

import './amplifyconfiguration.dart';

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
          displaySmall: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          titleMedium: TextStyle(
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
  // loading ui state - initially set to a loading state
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // kick off app initialization
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // configure Amplify
    await _configureAmplify();

    // after configuring Amplify, update loading ui state to loaded state
    setState(() {
      _isLoading = false;
    });
  }

  void _changeTab(label) {
    setState(() {
      _activeRoute = routes[label]!['route'];
    });
  }

  Future<void> _configureAmplify() async {
    try {
      // amplify plugins

      final restApiPlugin = AmplifyAPI();
      final authPlugin = AmplifyAuthCognito();

      // add Amplify plugins
      await Amplify.addPlugins([restApiPlugin, authPlugin]);

      // configure Amplify
      //
      // note that Amplify cannot be configured more than once!
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      // error handling can be improved for sure!
      // but this will be sufficient for the purposes of this tutorial
      safePrint('An error occurred while configuring Amplify: $e');
    }
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _activeRoute,
      bottomNavigationBar: BottomNavBarWidget(
        navigateTo: _changeTab,
        routes: routes,
      ),
    );
  }
}
