import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Services/global_methods.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/text_widget.dart';
import 'package:grocery_app/inner_screens/product_details_screen.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).screenSize;
    return ListTile(
      leading: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: FancyShimmerImage(
          imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
          errorWidget: Image.asset('assets/images/cat/fruits.png'),
          width: size.width * 0.15,
          // height: size.width * 0.5,
          boxFit: BoxFit.fill,
        ),
      ),
      onTap: () {
        GlobalMethods.navigateTo(
          context: context,
          routeName: ProductDetailsScreen.routeName,
        );
      },
      title: TextWidget(title: 'title x12', color: color, textSize: 18),
      subtitle: Text('Paid: \$10.99'),
      trailing: TextWidget(title: '08/05/2026', color: color, textSize: 18),
    );
  }
}
