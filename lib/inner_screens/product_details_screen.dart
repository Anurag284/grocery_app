import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Providers/cart_provider.dart';
import 'package:grocery_app/Providers/product_provider.dart';
import 'package:grocery_app/Providers/viewed_provider.dart';
import 'package:grocery_app/Providers/wishlist_provider.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/heart_button.dart';
import 'package:grocery_app/Widget/text_widget.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/ProductDetails';

  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final quantityTextController = TextEditingController(text: '1');
  @override
  void dispose() {
    quantityTextController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    Size size = Utils(context).screenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final prodId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurentProduct = productProviders.findProdById(prodId);
    final viewdProdProvider = Provider.of<ViewedProvider>(context);

    double usedPrice =
        getCurentProduct.isOnSale
            ? getCurentProduct.salePrice
            : getCurentProduct.price;
    double totalPrice = usedPrice * double.parse(quantityTextController.text);
    bool? isInCart = cartProvider.getCartItems.containsKey(getCurentProduct.id);
    final wishListProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishList = wishListProvider.getWishlistItems.containsKey(
      getCurentProduct.id,
    );
    return WillPopScope(
      onWillPop: () async {
        viewdProdProvider.addProdToViewed(prodId: prodId);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              //This is to make sure when pressed return to the same previous screen
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            child: Icon(IconlyLight.arrowLeft2, color: color, size: 24),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // backgroundColor: Colors.amber,
        ),
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: FancyShimmerImage(
                imageUrl: getCurentProduct.imageUrl,
                errorWidget: Image.asset('assets/images/cat/fruits.png'),
                width: size.width * 0.8,
                // height: size.height * 0.36,
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  // color: Theme.of(context).cardColor,
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextWidget(
                              title: getCurentProduct.title,
                              color: color,
                              textSize: 25,
                              isTitle: true,
                            ),
                          ),
                          HeartButton(
                            prodId: getCurentProduct.id,
                            isInWishList: isInWishList,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //used Price
                          TextWidget(
                            title: '\$ ${usedPrice.toStringAsFixed(2)}/',
                            color: Colors.green,
                            textSize: 22,
                            isTitle: true,
                          ),
                          TextWidget(
                            title: getCurentProduct.isPiece ? 'Piece' : 'KG',
                            color: color,
                            textSize: 12,
                            isTitle: false,
                          ),
                          SizedBox(width: 10),
                          Visibility(
                            visible: getCurentProduct.isOnSale ? true : false,
                            child: Text(
                              '\$ ${getCurentProduct.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 15,
                                color: color,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextWidget(
                              title: 'Free Delivery',
                              color: Colors.white,
                              textSize: 20,
                              isTitle: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _quantityWidget(
                          fct: () {
                            if (quantityTextController.text == '1') {
                              return;
                            } else {
                              setState(() {
                                quantityTextController.text =
                                    (int.parse(quantityTextController.text) - 1)
                                        .toString();
                              });
                            }
                          },
                          icon: CupertinoIcons.minus_square,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: quantityTextController,
                            key: ValueKey('quantity'),
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp('[0-9]'),
                              ),
                            ],
                            onChanged: (v) {
                              setState(() {
                                if (v.isEmpty) {
                                  quantityTextController.text = '1';
                                } else {
                                  return;
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        _quantityWidget(
                          fct: () {
                            setState(() {
                              quantityTextController.text =
                                  (int.parse(quantityTextController.text) + 1)
                                      .toString();
                            });
                          },
                          icon: CupertinoIcons.plus_square,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 30,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  title: 'Total',
                                  color: Colors.red,
                                  textSize: 20,
                                  isTitle: true,
                                ),
                                SizedBox(height: 2),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        title:
                                            '\$ ${totalPrice.toStringAsFixed(2)}/',
                                        color: color,
                                        textSize: 22,
                                        isTitle: true,
                                      ),
                                      TextWidget(
                                        title:
                                            '${quantityTextController.text}${getCurentProduct.isPiece ? 'Piece' : 'Kg'}',
                                        color: color,
                                        textSize: 16,
                                        isTitle: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: Material(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap:
                                    isInCart
                                        ? null
                                        : () {
                                          cartProvider.addProdToCart(
                                            prodId: getCurentProduct.id,
                                            quantity: int.parse(
                                              quantityTextController.text,
                                            ),
                                          );
                                        },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextWidget(
                                    title: isInCart ? 'In Cart' : 'Add to Cart',
                                    color: Colors.white,
                                    textSize: 18,
                                    isTitle: false,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityWidget({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () {
              fct();
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
