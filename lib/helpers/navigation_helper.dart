import 'dart:developer';

import 'package:flutter/material.dart';

class Navigation {
  void goToScreen(BuildContext context, Widget Function(BuildContext context) pageName, dynamic futureor) async {
    log('Going To Page >> $pageName');
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: pageName,
          ),
        )
        .then(futureor);
  }

  void goToScreenAndFinish(BuildContext context, Widget Function(BuildContext context) pageName) {
    log('Going To Page >> $pageName');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: pageName,
      ),
      (route) => false,
    );
  }
}
