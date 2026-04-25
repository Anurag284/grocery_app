import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Provider/dark_theme_provider.dart';
import 'package:grocery_app/Screens/cart.dart';
import 'package:grocery_app/Screens/category.dart';
import 'package:grocery_app/Screens/home_scree.dart';
import 'package:grocery_app/Screens/user.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Map<String, dynamic>> _pages = [
    {'page': HomeScreen(), 'title': "Home Screen"},
    {'page': CategoryScreen(), 'title': "Categories"},
    {'page': CartScreen(), 'title': "Cart Screen"},
    {'page': UserScreen(), 'title': "User Screen"},
  ];
  int _selectIndex = 0;
  void _selectedPage(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.darkTheme;
    return Scaffold(
      // appBar: AppBar(title: Text(_pages[_selectIndex]['title'])),
      body: _pages[_selectIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectIndex,
        unselectedItemColor: _isDark ? Colors.white70 : Colors.black87,
        selectedItemColor: _isDark ? Colors.lightBlue : Colors.black87,
        onTap: _selectedPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(_selectIndex == 0 ? IconlyBold.home : IconlyLight.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectIndex == 1 ? IconlyBold.category : IconlyLight.category,
            ),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectIndex == 3 ? IconlyBold.user2 : IconlyLight.user2,
            ),
            label: "User",
          ),
        ],
      ),
    );
  }
}
