import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Function? validateFunc(value) => null;

class MainTextFormField extends StatelessWidget {
  MainTextFormField({
    this.labelText = 'Email Address',
    this.isobscure = false,
    this.showForgotPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator = validateFunc,
    required this.textEditingController,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
  });

  final String labelText;
  final bool isobscure;
  final bool showForgotPassword;
  final TextInputType keyboardType;
  final Function validator;
  final TextEditingController textEditingController;
  final TextAlign textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    InputBorder textBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: theme.accentColor, width: 2),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: theme.textTheme.subtitle1,
        ),
        SizedBox(height: 5),
        TextFormField(
          inputFormatters: [
            if (keyboardType == TextInputType.number)
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          maxLines: maxLines,
          validator: (value) => validator(value!),
          controller: textEditingController,
          cursorColor: theme.accentColor,
          keyboardAppearance: theme.brightness,
          keyboardType: keyboardType,
          cursorWidth: 2,
          style: theme.textTheme.subtitle1,
          textAlign: textAlign,
          decoration: InputDecoration(
            hintText: textAlign == TextAlign.center ? '0' : '',
            hintStyle: theme.textTheme.subtitle1,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
            focusedBorder: textBorder,
            enabledBorder: textBorder.copyWith(
                borderSide:
                    BorderSide(color: theme.iconTheme.color!.withOpacity(.3))),
            focusedErrorBorder: textBorder.copyWith(
              borderSide: BorderSide(color: Colors.red),
            ),
            errorBorder: textBorder.copyWith(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
