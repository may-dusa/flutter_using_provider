import 'package:flutter/material.dart';

import '../themes/texttheme.dart';

enum InputType { text, date, multiline }

InputDecoration _inputStyle({String? label, required String hintText}) {
  return InputDecoration(
      iconColor: Colors.black87,
      hintText: hintText,
      hintStyle: typography.bodyText1!.copyWith(color: Colors.black45),
      errorStyle:
          typography.bodyText1!.copyWith(color: Colors.red.withOpacity(0.7)),
      //contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      filled: true,
      fillColor: Colors.transparent,
      border: InputBorder.none);
}

class InputField extends TextField {
  InputField({
    Key? key,
    required String hintText,
    required TextEditingController controller,
    FocusNode? focusNode,
    Function(String)? onChanged,
    InputType inputType = InputType.text,
  }) : super(
          onChanged: onChanged,
          decoration: _inputStyle(hintText: hintText),
          focusNode: focusNode,
          controller: controller,
          style:
              typography.headline2!.copyWith(decoration: TextDecoration.none),
          textAlignVertical: TextAlignVertical.top,
          maxLines: 3,
          minLines: 1,
          cursorColor: Colors.black87,
          cursorRadius: const Radius.circular(2),
        );
}

TextField t = TextField();
