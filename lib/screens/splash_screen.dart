import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 300,
                child: Image.asset('assets/logo.png'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Ebra w 5et'),
            const SizedBox(
              height: 10,
            ),
            const CircularProgressIndicator.adaptive(),
          ],
        ),
      ),
    );
  }
}
