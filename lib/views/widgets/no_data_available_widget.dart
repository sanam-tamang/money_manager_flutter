
import 'package:flutter/material.dart';

import '../../core/color_pallete.dart';

class NoDataAvailableWidget extends StatelessWidget {
  const NoDataAvailableWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 50,
          child: Icon(
            Icons.money_off,
            size: 80,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "No Data Available !!!",
          style: Theme.of(context).primaryTextTheme.bodyMedium?.copyWith( color: ColorPalette.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 20)
        ),
      ],
        ),
    );
  }
}
