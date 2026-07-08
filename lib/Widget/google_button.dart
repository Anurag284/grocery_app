import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/Consts/firbase_consts.dart';
import 'package:grocery_app/Screens/btm_bar.dart';
import 'package:grocery_app/Services/global_methods.dart';
import 'package:grocery_app/Widget/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  Future<void> _googleSignIn(BuildContext context) async {
    try {
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        serverClientId:
            '1081491290012-2j20ejs0kvd74ht0tqbeojd00b3jiv2m.apps.googleusercontent.com',
      );
      final googleAccount = await googleSignIn.authenticate();
      if (googleAccount == null) {
        GlobalMethods.errorDialog(
          subtitle: 'User cancelled the operation',
          context: context,
        );
        return;
      }
      final googleAuth = googleAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNavBar()),
      );
    } catch (error) {
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () => _googleSignIn(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Image.asset('assets/images/google.png', width: 40),
            ),
            SizedBox(width: 10),
            TextWidget(
              title: 'Sign in with Google',
              color: Colors.white,
              textSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
