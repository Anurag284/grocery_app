import 'package:flutter/material.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/categories_widget.dart';
import 'package:grocery_app/Widget/text_widget.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  List<Color> gridColor = [
    Color(0xff538175),
    Color(0xffF8A44C),
    Color(0xffF7A593),
    Color(0xffD3B0E0),
    Color(0xffFDE598),
    Color(0xffB7DFF5),
  ];
  List<Map<String, dynamic>> catInfo = [
    {'image': 'assets/images/cat/fruits.png', 'catText': 'Fruits'},
    {'image': 'assets/images/cat/veg.png', 'catText': 'Vegetables'},
    {'image': 'assets/images/cat/Spinach.png', 'catText': 'Spinach'},
    {'image': 'assets/images/cat/nuts.png', 'catText': 'Nuts'},
    {'image': 'assets/images/cat/spices.png', 'catText': 'Spices'},
    {'image': 'assets/images/cat/grains.png', 'catText': 'Grains'},
  ];
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          title: 'Categories',
          color: color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 230 / 260,
          crossAxisSpacing: 8, // Vertical Spacing
          mainAxisSpacing: 8, // Horzontal Spacing
          children: List.generate(6, (index) {
            return CategoriesWidget(
              catText: catInfo[index]['catText'],
              imgpath: catInfo[index]['image'],
              passedcolor: gridColor[index],
            );
          }),
        ),
      ),
    );
  }
}
