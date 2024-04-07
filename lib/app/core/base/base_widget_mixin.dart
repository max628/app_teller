import 'package:flutter/material.dart';

mixin BaseWidgetMixin on StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(context),
    );
  }

  Widget body(BuildContext context);
}
