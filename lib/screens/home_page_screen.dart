import 'package:ebra_w_5et/providers/auth_provider.dart';
import 'package:ebra_w_5et/providers/product_provider.dart';
import 'package:ebra_w_5et/widgets/list_products_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  /// A static variable that is used to identify the route.
  static const routeName = '/home-screen';

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Consumer<AuthProvider>(builder: (_, value, c) {
        print(value.user);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello ${value.user.name}',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Lets get a deal for you',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            const FetchProductsWidget(),
          ],
        );
      }),
    );
  }
}

class FetchProductsWidget extends StatelessWidget {
  const FetchProductsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          //TODO: Make dynamic
          Provider.of<ProductProvider>(context, listen: false).getProducts(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Consumer<ProductProvider>(
                  builder: (_, value, child) => ListProductsWidget(
                    products: value.products,
                  ),
                ),
    );
  }
}
