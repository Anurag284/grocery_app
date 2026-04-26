import 'package:flutter/material.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return FittedBox(
      child: Row(
        children: [
          TextWidget(title: '1.49\$', color: Colors.green, textSize: 22),
          SizedBox(width: 5),
          Text(
            '1.89\$',
            style: TextStyle(
              fontSize: 15,
              color: color,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
