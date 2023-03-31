import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../providers/auth_provider.dart' as custom;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../amplifyconfiguration.dart';
import '../routes.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import 'auth_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // loading ui state - initially set to a loading state
  bool _isLoading = true;
  final bool loggedIn = false;
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

  Future<void> _configureAmplify() async {
    try {
      // amplify plugins
      final restApiPlugin = AmplifyAPI();
      final authPlugin = AmplifyAuthCognito();

      // add Amplify plugins
      await Amplify.addPlugins([restApiPlugin, authPlugin]);

      // configure Amplify
      //
      try {
        await Amplify.configure(amplifyconfig);
      } on AmplifyAlreadyConfiguredException {
        safePrint(
            'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
      }
    } catch (e) {
      // error handling can be improved for sure!
      // but this will be sufficient for the purposes of this tutorial
      safePrint('An error occurred while configuring Amplify: $e');
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<custom.AuthProvider>(context, listen: false)
          .getUserAttributes(),
      builder: (_, snapShot) =>
          snapShot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Consumer<custom.AuthProvider>(
                  builder: (_, value, c) =>
                      value.isSignedIn ? const MainBody() : c!,
                  child: const AuthenticationScreen(),
                ),
    );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  Widget? _activeRoute;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activeRoute = routes['Home']!['route'];
    routes['Home']!['active'] = true;
  }

  void _changeTab(label) {
    setState(() {
      _activeRoute = routes[label]!['route'];
    });
  }

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
