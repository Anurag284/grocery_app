import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Consts/constss.dart';
import 'package:grocery_app/Consts/firbase_consts.dart';
import 'package:grocery_app/Screens/Auth/forget_password.dart';
import 'package:grocery_app/Screens/Auth/login.dart';
import 'package:grocery_app/Screens/loading_manager.dart';
import 'package:grocery_app/Services/global_methods.dart';
import 'package:grocery_app/Widget/auth_button.dart';
import 'package:grocery_app/Widget/back_widget.dart';
import 'package:grocery_app/Widget/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _fullNameController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var obscureText = true;
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _addressTextController.dispose();
    _passFocusNode.dispose();
    _emailFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitFormSignUp() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    if (isValid) {
      print("the form is valid");

      try {
        await authInstance.createUserWithEmailAndPassword(
          email: _emailTextController.text.toLowerCase().trim(),
          password: _passwordTextController.text,
        );
        print('User created successfully');
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
          subtitle: '${error.message}',
          context: context,
        );
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
      // _formKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
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
            Container(color: Colors.black.withOpacity(0.6)),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 150.0),
                    BackWidget(),
                    SizedBox(height: 60),
                    TextWidget(
                      title: 'Welcome Back',
                      color: Colors.white,
                      textSize: 30,
                      isTitle: true,
                    ),
                    SizedBox(height: 10),
                    TextWidget(
                      title: 'Sign up to Continue',
                      color: Colors.white,
                      textSize: 18,
                      isTitle: false,
                    ),
                    SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete:
                                () => FocusScope.of(
                                  context,
                                ).requestFocus(_emailFocusNode),
                            controller: _fullNameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field is required';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete:
                                () => FocusScope.of(
                                  context,
                                ).requestFocus(_passFocusNode),
                            controller: _emailTextController,
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _emailFocusNode,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          //password
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              FocusScope.of(
                                context,
                              ).requestFocus(_addressFocusNode);
                            },
                            controller: _passwordTextController,
                            focusNode: _passFocusNode,
                            obscureText: obscureText,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Please enter your password';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                child: Icon(
                                  obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          //Address
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () {
                              _submitFormSignUp();
                            },
                            controller: _addressTextController,
                            focusNode: _addressFocusNode,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 10) {
                                return 'Please enter a valid Address';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Shipping Address',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          GlobalMethods.navigateTo(
                            context: context,
                            routeName: ForgetPasswordScreen.routeName,
                          );
                        },
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.lightBlue,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    AuthButton(
                      fct: () {
                        _submitFormSignUp();
                      },
                      buttonText: 'Sign Up',
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: 'Already a user? ',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      LoginScreen.routeName,
                                    );
                                  },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
