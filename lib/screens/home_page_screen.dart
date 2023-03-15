import 'package:ebra_w_5et/models/products_modal.dart' as product;
import 'package:ebra_w_5et/widgets/list_products_widget.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  /// A static variable that is used to identify the route.
  static const routeName = '/home-screen';
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
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Lets get a deal for you',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(
            height: 10,
          ),
          ListProductsWidget(products: [
            product.Product(
              id: 'id',
              name: 'test',
              price: 10,
              description: 'test',
              original_price: 20,
              image: product.Image(
                url: 'test',
              ),
            ),
            product.Product(
              id: 'id',
              name: 'test',
              price: 10,
              description: 'test',
              original_price: 20,
              image: product.Image(
                url: 'test',
              ),
            ),
            product.Product(
              id: 'id',
              name: 'test',
              price: 10,
              description: 'test',
              original_price: 20,
              image: product.Image(
                url: 'test',
              ),
            ),
            product.Product(
              id: 'id',
              name: 'test',
              price: 10,
              description: 'test',
              original_price: 20,
              image: product.Image(
                url: 'test',
              ),
            ),
            product.Product(
              id: 'id',
              name: 'test',
              price: 10,
              description: 'test',
              original_price: 20,
              image: product.Image(
                url: 'test',
              ),
            ),
            product.Product(
              id: 'id',
              name: 'test',
              price: 10,
              description: 'test',
              original_price: 20,
              image: product.Image(
                url: 'test',
              ),
            ),
            product.Product(
              id: 'id',
              name: 'test',
              price: 10,
              description: 'test',
              original_price: 20,
              image: product.Image(
                url: 'test',
              ),
            ),
            product.Product(
              id: 'id',
              name: 'test',
              price: 10,
              description: 'test',
              original_price: 20,
              image: product.Image(
                url: 'test',
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
