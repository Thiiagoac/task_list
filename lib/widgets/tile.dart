import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Tile extends StatelessWidget {
  final String title;
  final Widget trailing;
  final Widget child;
  final EdgeInsetsGeometry padding;

  final double _lineWidth = 5;
  final double _titleMarginLeft = 24;
  final double _minHeight = 48;

  const Tile({
    Key key,
    @required this.title,
    this.trailing,
    this.child,
    this.padding = const EdgeInsets.only(left: 16, top: 8, bottom: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _childMarginLeft = _lineWidth + _titleMarginLeft;

    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: new BorderRadius.circular(15),
      ),
      padding: this.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(minHeight: _minHeight),
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Container(
                    width: _lineWidth,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: _titleMarginLeft),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  trailing ?? Container(),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: _childMarginLeft),
            child: child,
          )
        ],
      ),
    );
  }
}
