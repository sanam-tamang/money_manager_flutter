import 'package:flutter/material.dart';
import 'package:money_manager/core/color_pallete.dart';

import '../../blocs/exports.dart';

class DateCounterButton extends StatelessWidget {
  const DateCounterButton(
      {super.key,
      this.iconColor = ColorPalette.textColor,
      required this.labelInOveral});
  final Color? iconColor;
  final String labelInOveral;
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .primaryTextTheme
        .bodyLarge
        ?.copyWith(color: iconColor);
    return BlocBuilder<DateCounterBloc, DateCounterState>(
      builder: (context, state) {
        if (state is DateCounterLoadedState) {
          if (state.printableDate.isEmpty) {
            return Text(
              labelInOveral,
              style: style?.copyWith(fontSize: 18),
            );
          }
          return SizedBox(
            height: 33,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      context
                          .read<DateCounterBloc>()
                          .add(const DecrementDateCounter());
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: iconColor,
                      size: 20,
                    )),
                Text(
                  state.printableDate,
                  style: style,
                ),
                IconButton(
                    onPressed: () {
                      context
                          .read<DateCounterBloc>()
                          .add(const IncrementDateCounter());
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      color: iconColor,
                      size: 20,
                    )),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
