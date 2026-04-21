import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Provider/dark_theme_provider.dart';
import 'package:grocery_app/Widget/text_widget.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.darkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Hi, ",
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "My Name",
                        style: TextStyle(
                          color: color,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                print("My Name is pressed");
                              },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                TextWidget(
                  title: 'email@hmail.com',
                  color: color,
                  textSize: 18,
                ),
                SizedBox(height: 20),
                Divider(thickness: 2),
                SizedBox(height: 20),
                _listTile(
                  title: 'Address',
                  subtitle: 'Address info',
                  icon: IconlyLight.profile,
                  onPressed: () {},
                  color: color,
                ),
                _listTile(
                  title: 'Orders',
                  // subtitle: 'Your order history',
                  icon: IconlyLight.bag2,
                  onPressed: () {},
                  color: color,
                ),
                _listTile(
                  title: 'Whishlist',
                  // subtitle: 'Your favourite products',
                  icon: IconlyLight.heart,
                  onPressed: () {},
                  color: color,
                ),
                _listTile(
                  title: 'Viewed',
                  // subtitle: 'Your viewed products',
                  icon: IconlyLight.show,
                  onPressed: () {},
                  color: color,
                ),
                _listTile(
                  title: 'Forget Password',
                  // subtitle: 'Reset your password',
                  icon: IconlyLight.unlock,
                  onPressed: () {},
                  color: color,
                ),
                SwitchListTile(
                  title: TextWidget(
                    title: themeState.darkTheme ? 'Dark Theme' : 'Light Theme',
                    color: color,
                    textSize: 22,
                  ),
                  secondary: Icon(
                    themeState.darkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                  ),
                  value: themeState.darkTheme,
                  onChanged: (bool value) {
                    setState(() {
                      themeState.setDarkTheme = value;
                    });
                  },
                ),
                _listTile(
                  title: 'Logout',
                  // subtitle: 'Logout from the app',
                  icon: IconlyLight.logout,
                  onPressed: () {},
                  color: color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listTile({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(title: title, color: color, textSize: 22),
      subtitle: TextWidget(
        title: subtitle == null ? "" : subtitle,
        color: color,
        textSize: 14,
        isTitle: true,
      ),
      leading: Icon(icon),
      trailing: Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
