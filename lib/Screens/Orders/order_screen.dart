import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Screens/Orders/order_widget.dart';
import 'package:grocery_app/Services/global_methods.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/empty_screen.dart';
import 'package:grocery_app/Widget/text_widget.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/OrderScreen';
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    bool _isEmpty = false;
    return _isEmpty
        ? EmptyScreen(
          title: 'You didn\'t place any orders',
          subtitle: 'Order something to get started',
          imagePath: 'assets/images/cart.png',
          buttonText: 'Shop Now',
        )
        : Scaffold(
          appBar: AppBar(
            // centerTitle: true,
            leading: BackButton(),
            title: TextWidget(
              title: 'Your Orders (2)',
              color: color,
              textSize: 22,
              isTitle: true,
            ),

            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: ListView.separated(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 2.0,
                  vertical: 6,
                ),
                child: OrderWidget(),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(color: color);
            },
          ),
        );
  }
}
