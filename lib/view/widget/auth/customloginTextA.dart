import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CostumTextTitle extends StatelessWidget {
  final String text;
  const CostumTextTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text.tr,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
