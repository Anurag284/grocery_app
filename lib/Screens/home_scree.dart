import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/feed_items.dart';
import 'package:grocery_app/Widget/on_sale_widget.dart';
import 'package:grocery_app/Widget/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offerImages = [
    'assets/images/offers/Offer1.jpg',
    'assets/images/offers/Offer2.jpg',
    'assets/images/offers/Offer3.jpg',
    'assets/images/offers/Offer4.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = Utils(context).color;
    final themeState = utils.getTheme;
    Size size = utils.screenSize;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.33,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(_offerImages[index], fit: BoxFit.fill);
                },
                autoplay: true,
                itemCount: _offerImages.length,
                pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.red,
                  ),
                ),
                // control: SwiperControl(color: Colors.black),
              ),
            ),
            SizedBox(height: 6),
            TextButton(
              onPressed: () {},
              child: TextWidget(
                title: 'View All',
                color: Colors.blue,
                textSize: 20,
                isTitle: true,
              ),
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    children: [
                      TextWidget(
                        title: 'On Sale'.toUpperCase(),
                        color: Colors.red,
                        textSize: 22,
                        isTitle: true,
                      ),
                      SizedBox(width: 5),
                      Icon(IconlyLight.discount, color: Colors.red),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: SizedBox(
                    height: size.height * 0.24,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return OnSaleWidget();
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    title: 'Our Product',
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                  // Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: TextWidget(
                      title: 'Browse All',
                      color: Colors.blue,
                      textSize: 20,
                      isTitle: true,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              // crossAxisSpacing: 10,
              childAspectRatio: size.width / (size.height * 0.6),
              children: List.generate(4, (index) => FeedItems()),
            ),
          ],
        ),
      ),
    );
  }
}
