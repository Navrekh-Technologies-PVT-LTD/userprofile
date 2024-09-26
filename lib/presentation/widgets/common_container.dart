import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer(
      {super.key,
      this.height,
      this.width,
      this.border,
      this.borderRadius,
      this.color,
      this.boxShape,
      this.gradient,
      this.child,
      this.image,
      this.onTap,
      this.padding,
      this.boxShadow});
  final double? height;
  final double? width;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final BoxShape? boxShape;
  final Gradient? gradient;
  final Widget? child;
  final DecorationImage? image;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;
  final List<BoxShadow>? boxShadow;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: boxShape ?? BoxShape.rectangle,
          border: border,
          borderRadius: borderRadius,
          color: color,
          gradient: gradient,
          image: image,
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}

loadingWidgetForBtn() {
  return Transform.scale(
    scale: 0.5,
    child: const CircularProgressIndicator(
      color: Colors.white,
    ),
  );
}
