import 'package:flutter/material.dart';
import 'package:grocery_app/Provider/dark_theme_provider.dart';
import 'package:grocery_app/Screens/btm_bar.dart';
import 'package:grocery_app/inner_screens/feeds_screens.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/inner_screens/product_details_screen.dart';
import 'package:provider/provider.dart';
// import 'package:grocery_app/Screens/home_scree.dart';
import 'package:grocery_app/Consts/theme_data.dart';

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
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Styles.themeData(themeProvider.darkTheme, context),
            home: BottomNavBar(),
            routes: {
              OnSaleScreen.routeName: (context) => OnSaleScreen(),
              FeedsScreens.routeName: (context) => FeedsScreens(),
              ProductDetailsScreen.routeName:
                  (context) => ProductDetailsScreen(),
            },
          );
        },
      ),
    );
  }
}
