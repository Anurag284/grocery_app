import 'package:flutter/material.dart';
import 'package:grocery_app/Services/global_methods.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/text_widget.dart';
import 'package:grocery_app/inner_screens/feeds_screens.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });

  final String imagePath, title, subtitle, buttonText;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    final themeState = Utils(context).getTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Image.asset(
                imagePath,
                width: double.infinity,
                height: size.height * 0.5,
              ),
              SizedBox(height: 10),
              Text(
                'Whoops!',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              TextWidget(title: title, color: Colors.cyan, textSize: 20),
              SizedBox(height: 10),
              TextWidget(title: subtitle, color: Colors.cyan, textSize: 20),
              SizedBox(height: size.height * 0.1),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: color),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  // textStyle: TextStyle(
                  //   fontSize: 20,
                  //   fontWeight: FontWeight.w700,
                  // ),
                ),
                onPressed: () {
                  GlobalMethods.navigateTo(
                    context: context,
                    routeName: FeedsScreens.routeName,
                  );
                },
                child: TextWidget(
                  title: buttonText,
                  textSize: 20,
                  color:
                      themeState ? Colors.grey.shade300 : Colors.grey.shade800,
                  isTitle: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
