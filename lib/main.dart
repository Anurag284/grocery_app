import 'package:flutter/material.dart';
import 'package:grocery_app/Provider/dark_theme_provider.dart';
import 'package:grocery_app/Providers/product_provider.dart';
import 'package:grocery_app/Screens/Auth/forget_password.dart';
import 'package:grocery_app/Screens/Auth/login.dart';
import 'package:grocery_app/Screens/Auth/signup.dart';
import 'package:grocery_app/Screens/Orders/order_screen.dart';
import 'package:grocery_app/Screens/Viewed_recently/viewed_screen.dart';
import 'package:grocery_app/Screens/Wishlist/wishlist_screen.dart';
import 'package:grocery_app/Screens/btm_bar.dart';
import 'package:grocery_app/Screens/category.dart';
import 'package:grocery_app/inner_screens/feeds_screens.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/inner_screens/product_details_screen.dart';
import 'package:provider/provider.dart';
// import 'package:grocery_app/Screens/home_scree.dart';
import 'package:grocery_app/Consts/theme_data.dart';

import 'inner_screens/cat_screen.dart' show CategoryInnerScreen;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getDarkTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Styles.themeData(themeProvider.darkTheme, context),
            home: BottomNavBar(),
            routes: {
              LoginScreen.routeName: (context) => LoginScreen(),
              SignupScreen.routeName: (context) => SignupScreen(),
              ForgetPasswordScreen.routeName:
                  (context) => ForgetPasswordScreen(),
              OnSaleScreen.routeName: (context) => OnSaleScreen(),
              FeedsScreens.routeName: (context) => FeedsScreens(),
              ProductDetailsScreen.routeName:
                  (context) => ProductDetailsScreen(),
              WishlistScreen.routeName: (context) => WishlistScreen(),
              OrderScreen.routeName: (context) => OrderScreen(),
              ViewedScreen.routeName: (context) => ViewedScreen(),
              CategoryInnerScreen.routeName: (context) => CategoryInnerScreen(),
            },
          );
        },
      ),
    );
  }
}
