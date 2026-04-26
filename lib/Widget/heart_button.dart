import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Services/utils.dart';

class HeartButton extends StatelessWidget {
  const HeartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () {
        print("Print hear icon presswd");
      },
      child: Icon(IconlyLight.heart, size: 22, color: color),
    );
  }
}
