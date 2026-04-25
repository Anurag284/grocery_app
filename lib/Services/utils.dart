import 'package:flutter/material.dart';
import 'package:grocery_app/Provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get getTheme => Provider.of<DarkThemeProvider>(context).darkTheme;
  Color get color => getTheme ? Colors.white : Colors.black;
  Size get screenSize => MediaQuery.of(context).size;
}
