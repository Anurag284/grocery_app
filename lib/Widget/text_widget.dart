import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextWidget extends StatefulWidget {
  TextWidget({
    super.key,
    required this.title,
    required this.color,
    required this.textSize,
    this.isTitle = false,
    this.maxLines = 10,
  });
  final String title;
  final Color color;
  final double textSize;
  bool isTitle;
  int maxLines = 10;

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: widget.color,
        fontSize: widget.textSize,
        fontWeight: widget.isTitle ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
