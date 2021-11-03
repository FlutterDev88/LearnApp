// Spacing
import 'package:flutter/material.dart';

const double kPadding1 = 3;
const double kPadding2 = 5;
const double kPadding3 = 10;
const double kPadding4 = 20;
const double kPadding5 = 30;
const double kPadding6 = 40;
const double kPadding7 = 50;
const double kPadding8 = 60;
const double kPadding9 = 70;
const double kPadding10 = 80;
const double kPadding11 = 90;
const double kPadding12 = 100;
const double kPadding13 = 150;
const double kPadding14 = 200;
const double kPadding15 = 300;

// Font Size
const double kHeaderFontSize = 40;

const double kBodyFontSize1 = 12;
const double kBodyFontSize2 = 14;
const double kBodyFontSize3 = 16;
const double kBodyFontSize4 = 18;
const double kBodyFontSize5 = 20;
const double kBodyFontSize6 = 24;
const double kBodyFontSize7 = 26;
const double kBodyFontSize8 = 28;
const double kBodyFontSize10 = 30;
const double kBodyFontSize11 = 32;
const double kBodyFontSize12 = 34;
const double kBodyFontSize13 = 36;

// Colors
const Color kGreenColor = Color(0xff3de460);
const Color kRedColor = Color(0xffe11313);
const Color kWhiteColor = Color(0xffffffff);
const Color kBlackColor = Color(0xff000000);

Color getColor(String color) {
  switch (color) {
    case 'white':
      return Colors.white;
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'yellow':
      return Colors.yellow;
    case 'black':
      return Colors.black;
  }

  return Colors.transparent;
}