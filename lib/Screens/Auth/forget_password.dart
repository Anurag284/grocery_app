import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Consts/constss.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/auth_button.dart';
import 'package:grocery_app/Widget/text_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgetPasswordScreen';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailTextController = TextEditingController();
  // bool isLoading = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  void _forgetPassFCT() async {}
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;
    return Scaffold(
      body: Stack(
        children: [
          Swiper(
            duration: 2000,
            autoplayDelay: 8000,
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                Constss.authImagesPath[index],
                fit: BoxFit.cover,
              );
            },
            autoplay: true,
            autoplayDisableOnInteraction: false,
            itemCount: Constss.authImagesPath.length,
          ),
          Container(color: Colors.black.withOpacity(0.7)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.1),
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap:
                      () =>
                          Navigator.canPop(context)
                              ? Navigator.pop(context)
                              : null,
                  child: Icon(
                    IconlyLight.arrowLeft2,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(height: 20),
                TextWidget(
                  title: 'Forget Password',
                  color: Colors.white,
                  textSize: 30,
                  isTitle: true,
                ),
                SizedBox(height: 40),
                TextField(
                  controller: _emailTextController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                AuthButton(
                  fct: () {
                    _forgetPassFCT();
                  },
                  buttonText: 'Reset Now',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
