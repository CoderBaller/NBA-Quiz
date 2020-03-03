import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nbaquiz/constants.dart';
import 'package:nbaquiz/screens/welcome.dart';
import 'package:nbaquiz/services/auth.dart';
import 'package:nbaquiz/services/models.dart';
import 'package:nbaquiz/shared/custom_button.dart';
import 'package:nbaquiz/shared/loader.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static String id = 'profile_screen';

  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    if (user != null) {
      final String name = (user.displayName != null && user.displayName != "")
          ? user.displayName
          : 'Invité';
      final String email =
          (user.email != null && user.email != "") ? user.email : 'Invité';
      final bool showPhoto = user.photoUrl != null;
      return Scaffold(
        appBar: AppBar(
          title: Text(
            email,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showPhoto)
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(user.photoUrl),
                    ),
                  ),
                ),
              SizedBox(height: showPhoto ? 10 : 30),
              Text(name,
                  style: kTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  )),
              SizedBox(height: 40),
              if (report != null)
                Text('${report.total ?? 0}',
                    style: kTextStyle.copyWith(fontSize: 64)),
              Text(
                'Quiz réussis',
                style: kTextStyle,
              ),
              SizedBox(height: 60),
              CustomButton(
                text: 'Se déconnecter',
                hPad: 40,
                loginFunc: () async {
                  await auth.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      WelcomeScreen.id, (route) => false);
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return LoadingScreen();
    }
  }
}
