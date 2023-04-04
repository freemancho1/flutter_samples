import 'package:flutter/material.dart';
import 'package:flutter_samples/system/config.dart';

class MakeLoadingMessage extends StatelessWidget {
  final String message;
  const MakeLoadingMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          message,
          style: SystemCfg.loadingMessageStyle,
          maxLines: 1,
        ),
      );
}
