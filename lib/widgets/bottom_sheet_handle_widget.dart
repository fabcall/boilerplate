import 'package:flutter/material.dart';

class BottomSheetHandleWidget extends StatelessWidget {
  const BottomSheetHandleWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 80.0,
        height: 5.0,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: Color(0xFFDEDEDE),
          ),
        ),
      ),
    );
  }
}
