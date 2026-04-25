import 'package:flutter/material.dart';
import 'package:grocery_app/Provider/dark_theme_provider.dart';
import 'package:grocery_app/Widget/text_widget.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({
    super.key,
    required this.catText,
    required this.imgpath,
    required this.passedcolor,
  });
  String catText, imgpath;
  final Color passedcolor;
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.darkTheme ? Colors.white : Colors.black;
    double _screenwidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        print("Category tapped");
      },
      child: Container(
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: passedcolor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: passedcolor.withOpacity(0.7), width: 2),
        ),
        child: Column(
          children: [
            Container(
              height: _screenwidth * 0.3,
              width: _screenwidth * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgpath),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            TextWidget(
              title: catText,
              color: color,
              textSize: 20,
              isTitle: true,
            ),
          ],
        ),
      ),
    );
  }
}
