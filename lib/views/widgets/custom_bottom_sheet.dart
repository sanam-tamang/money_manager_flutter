import 'package:flutter/material.dart';

///custom bottomsheet helps to show bottomsheet
void customModalBottomSheet(
    {required BuildContext context,
    required Widget child,
    required String label}) {
  showModalBottomSheet(
      // backgroundColor: Colors.white10,
      barrierColor: Colors.transparent,
      elevation: 0,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                width: double.maxFinite,
                color: Colors.black87,
                child: Text(label,
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
              ),

              ///child widget
              child,
            ],
          ),
        );
      });
}
