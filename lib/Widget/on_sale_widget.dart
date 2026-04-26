import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/price_widget.dart';
import 'package:grocery_app/Widget/text_widget.dart';

class OnSaleWidget extends StatelessWidget {
  const OnSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final Color color = Utils(context).color;
    Size size = Utils(context).screenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                      height: size.width * 0.22,
                      width: size.width * 0.22,
                      boxFit: BoxFit.fill,
                    ),
                    // Image.network(
                    //   'https://i.ibb.co/F0s3FHQ/Apricots.png',
                    //   // width: size.width * 0.22,
                    //   height: size.width * 0.22,
                    //   fit: BoxFit.fill,
                    // ),
                    Column(
                      children: [
                        TextWidget(
                          title: '1KG',
                          color: color,
                          textSize: 22,
                          isTitle: true,
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                IconlyLight.bag2,
                                size: 22,
                                color: color,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Print hear icon presswd");
                              },
                              child: Icon(
                                IconlyLight.heart,
                                size: 22,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                PriceWidget(),
                SizedBox(height: 5),
                TextWidget(
                  title: 'Product title',
                  color: color,
                  textSize: 16,
                  isTitle: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
