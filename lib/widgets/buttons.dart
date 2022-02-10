import 'package:catalog/themes/texttheme.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class RoundIconButtonStyle extends ButtonStyle {
  RoundIconButtonStyle({
    Color? color,
    Color? fColor,
  }) : super(
          backgroundColor: MaterialStateProperty.all(color ?? Colors.black87),
          foregroundColor: MaterialStateProperty.all(fColor ?? Colors.white),
          fixedSize: MaterialStateProperty.all(const Size(24, 24)),
          shape: MaterialStateProperty.all(const CircleBorder()),
          alignment: Alignment.center,
          elevation: MaterialStateProperty.all(0),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        );
}

class RoundIconButton extends TextButton {
  RoundIconButton({
    required IconData iconData,
    required Function() onPressFn,
    Color? color,
    Color? fColor,
  }) : super(
            child: Icon(
              iconData,
            ),
            onPressed: onPressFn,
            style: RoundIconButtonStyle(
                color: color ?? Colors.black87,
                fColor: fColor ?? Colors.white));

  factory RoundIconButton.notFilled(IconData iconData, Function() onPressFn,
      {Color? fColor}) {
    return RoundIconButton(
      iconData: iconData,
      onPressFn: onPressFn,
      color: Colors.transparent,
      fColor: fColor ?? Colors.black87,
    );
  }
}

class ExpandedTextButton extends TextButton {
  ExpandedTextButton(
      {Key? key, required String title, required Function() onPressFn})
      : super(
          onPressed: onPressFn,
          child: Text(
            title,
            style: typography.bodyText1!.copyWith(color: Colors.white),
          ),
          style: ExpandedTextButtonStyle(),
        );
}

class ExpandedTextButtonStyle extends ButtonStyle {
  ExpandedTextButtonStyle()
      : super(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 16)),
          backgroundColor: MaterialStateProperty.all(Colors.black87),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          fixedSize:
              MaterialStateProperty.all(const Size.fromWidth(double.maxFinite)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          alignment: Alignment.center,
          elevation: MaterialStateProperty.all(0),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        );
}
