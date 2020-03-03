import 'package:flutter/material.dart';

const kMainColor = Color(0xFF00264d);
const kBlueColor = Color(0xFF2f4487);

const kTextStyle = TextStyle(color: kMainColor);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: kMainColor),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kMainColor),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kMainColor),
  ),
);