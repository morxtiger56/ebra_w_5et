import 'package:flutter/material.dart';

import '../widgets/orders_management.dart';
import '../widgets/account_security.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Column(
          children: const [
            OrdersManagement(),
            AccountSecurity(),
          ],
        ),
      ),
    );
  }
}
