import 'package:flutter/material.dart';

import 'custom_bottom_sheet.dart';

///in this widget we wil fill date, category , amount and note etc
///and this widgets shows the modalbottomsheet which we pass
///through the child
class FillableTransactionWidget extends StatelessWidget {
  const FillableTransactionWidget(
      {Key? key,
      required this.text,
      required this.child,
      required this.fillabe})
      : super(key: key);
  final Widget child;
  final String text;
  final String? fillabe;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      GestureDetector(
          onTap: () {},
          child: Text(
            text,
            style: const TextStyle(color: Colors.grey),
          )),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: InkWell(
            onTap: () {
              customModalBottomSheet(
                  context: context, label: text, child: child);
            },
            child: Container(
              height: 20,
              color: Colors.white,
              child: fillabe != null
                  ? Text(fillabe.toString())
                  : const Baseline(
                      baseline: 35,
                      baselineType: TextBaseline.ideographic,
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
            )),
      ),
    ]);
  }
}
