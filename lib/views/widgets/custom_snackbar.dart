import 'package:flutter/material.dart';

void customSnackBar(BuildContext context, {required String label}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(label)));
}
