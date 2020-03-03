import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nbaquiz/screens/login.dart';
import 'package:nbaquiz/screens/register.dart';
import 'package:nbaquiz/screens/topics.dart';
import 'package:nbaquiz/services/auth.dart';
import 'package:nbaquiz/shared/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, TopicsScreen.id);
        }
      },
    );
  }

  Future<void> loginWithGoogle() async {
    var user = await auth.googleSignIn();
    if (user != null) {
      Navigator.pushReplacementNamed(context, TopicsScreen.id);
    }
  }

  Future<void> loginWithFacebook() async {
    var user = await auth.facebookSignIn();
    if (user != null) {
      Navigator.pushReplacementNamed(context, TopicsScreen.id);
    }
  }

  Future<void> loginAnon() async {
    var user = await auth.anonLogin();
    if (user != null) {
      Navigator.pushReplacementNamed(context, TopicsScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/nba-quiz.png',
              fit: BoxFit.contain,
            ),
            CustomButton(
              text: 'Se connecter avec Google',
              icon: FontAwesomeIcons.google,
              loginFunc: loginWithGoogle,
            ),
            CustomButton(
              text: 'Se connecter avec Facebook',
              icon: FontAwesomeIcons.facebook,
              loginFunc: loginWithFacebook,
            ),
            CustomButton(
              text: 'Se connecter par email',
              icon: FontAwesomeIcons.envelope,
              loginFunc: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            CustomButton(
              text: 'Pas encore de compte? Inscris toi',
              loginFunc: () {
                Navigator.pushNamed(context, RegisterScreen.id);
              },
            ),
            CustomButton(
              text: 'Se connecter en tant qu\'invité',
              loginFunc: loginAnon,
            ),
          ],
        ),
      ),
    );
  }
}
