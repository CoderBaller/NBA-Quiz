import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nbaquiz/constants.dart';
import 'package:nbaquiz/screens/login.dart';
import 'package:nbaquiz/screens/profile.dart';
import 'package:nbaquiz/screens/register.dart';
import 'package:nbaquiz/screens/topics.dart';
import 'package:provider/provider.dart';
import 'package:nbaquiz/screens/welcome.dart';
import 'package:nbaquiz/services/auth.dart';
import 'package:nbaquiz/services/globals.dart';
import 'package:nbaquiz/services/models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Report>.value(value: Global.reportRef.documentStream),
        StreamProvider<FirebaseUser>.value(value: AuthService().user),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // Named Routes
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id : (context) => LoginScreen(),
          RegisterScreen.id : (context) => RegisterScreen(),
          TopicsScreen.id: (context) => TopicsScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
        },

        // Theme
        theme: ThemeData(
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            color: kMainColor,
          ),
          textTheme: TextTheme(
            headline: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
