import 'package:flutter/material.dart';
import 'package:flutter_samples/system/config.dart';

class MakeLoadingIcon extends StatelessWidget {
  final String message;
  const MakeLoadingIcon({super.key, this.message = ''});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(
        width: 32,
        height: 32,
        child: CircularProgressIndicator(),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          message,
          style: SystemCfg.loadingMessageStyle,
          maxLines: 1,
        ),
      ),
    ],
  );
}
