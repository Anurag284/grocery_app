import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/on_sale_widget.dart';
import 'package:grocery_app/Widget/text_widget.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(IconlyLight.arrowLeft2, color: color),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          title: 'Product On Sale',
          color: color,
          textSize: 24.0,
          isTitle: true,
        ),
      ),
      body:
          isEmpty
              // ignore: dead_code
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.asset('assets/images/box.png'),
                      ),
                      Text(
                        'No Product on sale yet\n Stay Tuned!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: color,
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(0),
                // crossAxisSpacing: 10,
                childAspectRatio: size.width / (size.height * 0.49),
                children: List.generate(16, (index) => OnSaleWidget()),
              ),
    );
  }
}
