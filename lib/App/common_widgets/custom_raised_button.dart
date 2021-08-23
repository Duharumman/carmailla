import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    this.child,
    this.color,
    this.borderRadius: 16.0,
    this.height: 50.0,
    this.onPressed,
  });

  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return SizedBox(
      height: 50.0,
      // ignore: deprecated_member_use
      child: RaisedButton(
        child: child,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
