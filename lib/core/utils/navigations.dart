import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void pushReplacement(BuildContext context, String route) {
  return context.pushReplacement(route);
}

Future pushTo(BuildContext context, String route, {Object? extra}) {
  return context.push(route, extra: extra);
}

void pop(BuildContext context) {
  return context.pop();
}
