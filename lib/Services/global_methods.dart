import 'package:flutter/material.dart';

class GlobalMethods {
  static navigateTo({
    required BuildContext context,
    required String routeName,
  }) {
    Navigator.pushNamed(context, routeName);
  }

  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    required Function fct,
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              SizedBox(width: 8),
              Text(title),
            ],
          ),

          content: Text(subtitle, style: TextStyle(fontSize: 16)),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: Text('Cancel', style: TextStyle(color: Colors.cyan)),
            ),
            TextButton(
              onPressed: () {
                fct();
              },
              child: Text('OK', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
