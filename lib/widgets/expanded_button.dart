import 'package:flutter/material.dart';

class ExpandedRaisedButton extends StatelessWidget {
  final Widget child;
  final Color textColor;
  final Color color;
  final Function onPressed;
  final ShapeBorder shape;
  final EdgeInsetsGeometry padding;

  const ExpandedRaisedButton({
    Key key,
    this.textColor,
    this.color,
    @required this.onPressed,
    this.shape,
    this.padding,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            shape: shape,
            padding: padding,
            child: child,
            textColor: textColor,
            color: color,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}