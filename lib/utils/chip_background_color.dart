import 'package:flutter/material.dart';

Color backgroundColor(int metacrtitcScore) {
  switch (metacrtitcScore) {
    case >= 75 && < 100:
      return const Color.fromRGBO(93, 203, 130, 1.0);
    case >= 50 && < 75:
      return const Color.fromRGBO(245, 192, 89, 1.0);
    case >= 0 && < 50:
      return const Color.fromRGBO(237, 114, 119, 1.0);
  }
  return Colors.grey;
}
