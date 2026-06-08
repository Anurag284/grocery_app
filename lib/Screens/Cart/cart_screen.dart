import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Providers/cart_provider.dart';
import 'package:grocery_app/Screens/Cart/cart_widget.dart';
import 'package:grocery_app/Widget/empty_screen.dart';
import 'package:grocery_app/Services/global_methods.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/text_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    return cartItemList.isEmpty
        ? EmptyScreen(
          title: 'Your cart is Empty',
          subtitle: 'Add something and make me happy',
          imagePath: 'assets/images/cart.png',
          buttonText: 'Shop Now',
        )
        : Scaffold(
          appBar: AppBar(
            title: TextWidget(
              title: 'Cart (${cartItemList.length})',
              color: color,
              textSize: 22,
              isTitle: true,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  GlobalMethods.warningDialog(
                    title: 'Empty Cart',
                    subtitle: 'Are you sure?',
                    fct: () {
                      // Handle empty cart logic here
                      cartProvider.clearCart();
                    },
                    context: context,
                  );
                },
                icon: Icon(IconlyLight.delete, color: color),
              ),
            ],
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: Column(
            children: [
              checkOut(context: context),
              Expanded(
                child: ListView.builder(
                  itemCount: cartItemList.length,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: cartItemList[index],
                      child: CartWidget(q: cartItemList[index].quantity),
                    );
                  },
                ),
              ),
            ],
          ),
        );
  }

  Widget checkOut({required BuildContext context}) {
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    title: 'Order Now',
                    color: color,
                    textSize: 20,
                    isTitle: true,
                  ),
                ),
              ),
            ),
            Spacer(),
            FittedBox(
              child: TextWidget(
                title: 'Total : \$0.267',
                color: color,
                textSize: 18,
                isTitle: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
