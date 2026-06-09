import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Providers/cart_provider.dart';
import 'package:grocery_app/Providers/product_provider.dart';
import 'package:grocery_app/Providers/viewed_provider.dart';
import 'package:grocery_app/Services/global_methods.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/text_widget.dart';
import 'package:grocery_app/inner_screens/product_details_screen.dart';
import 'package:grocery_app/models/viewed_model.dart';
import 'package:provider/provider.dart';

class ViewedWidget extends StatefulWidget {
  const ViewedWidget({super.key});

  @override
  State<ViewedWidget> createState() => _ViewedWidgetState();
}

class _ViewedWidgetState extends State<ViewedWidget> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final viewedProdModel = Provider.of<ViewedProductModel>(context);
    final viewedProvider = Provider.of<ViewedProvider>(context);

    final getCurrentProduct = productsProvider.findProdById(
      viewedProdModel.prodId,
    );
    double usedPrice =
        getCurrentProduct.isOnSale
            ? getCurrentProduct.salePrice
            : getCurrentProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(
      getCurrentProduct.id,
    );

    Color color = Utils(context).color;
    Size size = Utils(context).screenSize;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          GlobalMethods.navigateTo(
            context: context,
            routeName: ProductDetailsScreen.routeName,
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FancyShimmerImage(
              imageUrl: getCurrentProduct.imageUrl,
              errorWidget: Image.asset('assets/images/cat/fruits.png'),
              width: size.width * 0.25,
              height: size.width * 0.25,
              boxFit: BoxFit.fill,
            ),
            SizedBox(width: 12),
            Column(
              children: [
                TextWidget(
                  title: getCurrentProduct.title,
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
                SizedBox(height: 12),
                TextWidget(
                  title: '\$${usedPrice.toStringAsFixed(2)}',
                  color: color,
                  textSize: 20,
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                color: Colors.green,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap:
                      _isInCart
                          ? null
                          : () {
                            cartProvider.addProdToCart(
                              prodId: getCurrentProduct.id,
                              quantity: 1,
                            );
                          },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      _isInCart ? Icons.check : IconlyBold.plus,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
