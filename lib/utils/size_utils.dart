import 'package:flutter/material.dart';

double sizer(BuildContext context, double size, {bool removeSafeArea = false}) {
  if ((MediaQuery.of(context).orientation == Orientation.portrait)) {
    return height(context, 1, removeSafeArea: removeSafeArea) * size;
  } else {
    return width(context, 1, removeSafeArea: removeSafeArea) * size;
  }
}

double height(BuildContext context, double height, {bool removeSafeArea = false}) {
  if (removeSafeArea) {
    return (MediaQuery.of(context).size.height - MediaQueryData.fromView(View.of(context)).padding.vertical) *
        height;
  }

  return MediaQuery.of(context).size.height * height;
}

double width(BuildContext context, double width, {bool removeSafeArea = false}) {
  if (removeSafeArea) {
    return (MediaQuery.of(context).size.width -
            MediaQueryData.fromView(View.of(context)).padding.horizontal) *
        width;
  }

  return MediaQuery.of(context).size.width * width;
}

bool isPortrait(BuildContext context) {
  if ((MediaQuery.of(context).orientation == Orientation.portrait)) {
    return true;
  } else {
    return false;
  }
}

SizedBox h(double h) {
  return SizedBox(height: h);
}

SizedBox w(double w) {
  return SizedBox(width: w);
}

Widget constHeight10() {
  return h(10);
}

Widget constWidth10() {
  return w(10);
}

Widget constHeight20() {
  return h(20);
}

Widget constWidth20() {
  return w(20);
}

Widget constBottom() {
  return h(100);
}

Widget constHeight15() {
  return h(15);
}

Widget constWeight10() {
  return w(10);
}

Widget constWeight20() {
  return w(20);
}
