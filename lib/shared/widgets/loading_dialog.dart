import 'package:flutter/material.dart';

class LoadingDialogWidget extends StatelessWidget {
  const LoadingDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Image.asset(
          'assets/images/wine_loading.gif',
          fit: BoxFit.cover,
        )
      ],
    );
  }
}
