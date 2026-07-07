import 'package:flutter/material.dart';

class LoadingManager extends StatelessWidget {
  const LoadingManager({
    super.key,
    required this.isLoading,
    required this.child,
  });
  final bool isLoading;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        isLoading
            ? Container(color: Colors.black.withOpacity(0.7))
            : Container(),
        isLoading
            ? Center(
              child: CircularProgressIndicator(
                color: const Color.fromARGB(255, 36, 15, 15),
              ),
            )
            : Container(),
      ],
    );
  }
}
