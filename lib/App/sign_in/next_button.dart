import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:yellow_carmailla/App/common_widgets/custom_raised_button.dart';

class Next_button extends CustomRaisedButton {
  Next_button({
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
          color: color,
          onPressed: onPressed,
        );
}
