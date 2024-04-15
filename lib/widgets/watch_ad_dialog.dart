import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchAdDialog extends StatelessWidget {
  final VoidCallback onComplete;

  const WatchAdDialog({
    super.key,
    required this.onComplete,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        CupertinoDialogAction(
            isDefaultAction: true,
            textStyle: TextStyle(color: Colors.green),
            child: Text('Watch Ad'),
            onPressed: () {
              Get.back();
              onComplete();
            }),
      ],
    );
  }
}
