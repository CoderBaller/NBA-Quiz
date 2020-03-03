import 'package:flutter/material.dart';
import 'package:nbaquiz/constants.dart';
import 'package:nbaquiz/screens/topics.dart';
import 'package:nbaquiz/services/auth.dart';
import 'package:nbaquiz/shared/custom_button.dart';
import 'package:nbaquiz/shared/loader.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text('Register'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'password'),
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    CustomButton(
                      text: 'Register',
                      loginFunc: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          var user = await auth.registerWithEmailAndPassword(
                              email, password);
                          if (user == null) {
                            setState(() {
                              loading = false;
                              error = 'Please supply a valid email';
                            });
                          } else {
                            Navigator.pushReplacementNamed(
                                context, TopicsScreen.id);
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
