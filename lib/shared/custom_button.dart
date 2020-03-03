import 'package:flutter/material.dart';
import 'package:nbaquiz/constants.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginFunc;
  final double hPad;

  const CustomButton(
      {Key key, this.text, this.icon, this.color, this.hPad, this.loginFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad ?? 0),
      child: FlatButton.icon(
        padding: EdgeInsets.all(18),
        icon: Visibility(
            child: Icon(icon, color: Colors.white),
            visible: icon != null,
          ),
        color: color ?? kMainColor,
        onPressed: () => loginFunc(),
        label: Expanded(
          child: Text(
            '$text',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
