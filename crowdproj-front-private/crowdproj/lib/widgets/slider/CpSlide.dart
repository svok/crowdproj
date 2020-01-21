import 'package:flutter/material.dart';

class CpSlide {
  const CpSlide({Image this.image, Text this.text});

  CpSlide.of({String image, String text = ""})
      : this(image: Image.asset(image), text: defaultText(text));

  final Image image;
  final Text text;

  static Text defaultText(String str) => Text(str,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ));
}
