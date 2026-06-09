import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/Providers/cart_provider.dart';
import 'package:grocery_app/Providers/product_provider.dart';
import 'package:grocery_app/Providers/wishlist_provider.dart';
import 'package:grocery_app/Services/global_methods.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/heart_button.dart';
import 'package:grocery_app/Widget/text_widget.dart';
import 'package:grocery_app/inner_screens/product_details_screen.dart';
import 'package:grocery_app/models/cart_model.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key, required this.q});
  final int q;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final quantityTextController = TextEditingController(text: '1');
  @override
  void initState() {
    quantityTextController.text = widget.q.toString();
    super.initState();
  }

  @override
  void dispose() {
    quantityTextController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    final getCurentProduct = productProvider.findProdById(cartModel.prodId);
    double usedPrice =
        getCurentProduct.isOnSale
            ? getCurentProduct.salePrice
            : getCurentProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishList = wishListProvider.getWishlistItems.containsKey(
      getCurentProduct.id,
    );
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.routeName,
          arguments: cartModel.prodId,
        );
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      height: size.width * 0.25,
                      width: size.width * 0.25,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: FancyShimmerImage(
                        imageUrl: getCurentProduct.imageUrl,
                        errorWidget: Image.asset(
                          'assets/images/cat/fruits.png',
                        ),

                        boxFit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          title: getCurentProduct.title,
                          color: color,
                          textSize: 20,
                          isTitle: true,
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: size.width * 0.4,
                          child: Row(
                            children: [
                              _quantityWidget(
                                fct: () {
                                  if (quantityTextController.text == '1') {
                                    return;
                                  } else {
                                    cartProvider.reduceQuantityByOne(
                                      cartModel.prodId,
                                    );
                                    setState(() {
                                      quantityTextController.text =
                                          (int.parse(
                                                    quantityTextController.text,
                                                  ) -
                                                  1)
                                              .toString();
                                    });
                                  }
                                },
                                icon: CupertinoIcons.minus,
                                color: Colors.red,
                              ),
                              Flexible(
                                child: TextField(
                                  controller: quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
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
                              _quantityWidget(
                                fct: () {
                                  cartProvider.increaseQuantityByOne(
                                    cartModel.prodId,
                                  );
                                  setState(() {
                                    quantityTextController.text =
                                        (int.parse(
                                                  quantityTextController.text,
                                                ) +
                                                1)
                                            .toString();
                                  });
                                },
                                icon: CupertinoIcons.plus,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              cartProvider.removeOneItem(getCurentProduct.id);
                            },
                            child: Icon(
                              CupertinoIcons.cart_badge_minus,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          SizedBox(height: 5),
                          HeartButton(
                            prodId: getCurentProduct.id,
                            isInWishList: isInWishList,
                          ),
                          SizedBox(height: 5),
                          TextWidget(
                            title: '\$${usedPrice.toStringAsFixed(2)}',
                            color: color,
                            textSize: 18,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
              ),
            ),
          ),
        ],
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
