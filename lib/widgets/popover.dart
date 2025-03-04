import 'package:flutter/material.dart';

class Popover extends StatelessWidget {
  const Popover({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // ignore: unnecessary_null_comparison
        children: [_buildHandle(context), if (child != null) child],
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.18,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Container(
          height: 3.0,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }
}
