import 'package:ebra_w_5et/helpers/api_service.dart';
import 'package:ebra_w_5et/models/products_modal.dart';
import 'package:ebra_w_5et/providers/auth_provider.dart';
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
    Provider.of<AuthProvider>(context, listen: false).getUserAttributes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello Mohamed',
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
          FutureBuilder(
            future: WooCommerceApi.getProducts(),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.done
                    ? ListProductsWidget(
                        products: (snapshot.data as List<Product>),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
          ),
        ],
      ),
    );
  }
}
