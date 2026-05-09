import 'package:flutter/material.dart';
import 'package:grocery_app/Widget/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Image.asset('assets/images/google.png', width: 40),
            ),
            SizedBox(width: 10),
            TextWidget(
              title: 'Sign in with Google',
              color: Colors.white,
              textSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
