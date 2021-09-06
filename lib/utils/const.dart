import 'package:flutter/material.dart';

Color accentColor = Colors.amber;

void navPush(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => widget),
  );
}

void navPushRemove(BuildContext context, Widget widget) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}
