import 'package:flutter/material.dart';

import '../../core/color_pallete.dart';

class CustomLeadingIcon extends StatelessWidget {
  const CustomLeadingIcon({super.key, this.iconColor = ColorPalette.backgroundColor});
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon:  Icon(
          Icons.keyboard_arrow_left_sharp,
          color: iconColor,
        ));
  }
}
