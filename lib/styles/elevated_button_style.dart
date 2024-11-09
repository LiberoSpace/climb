import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ElevatedButtonStyle extends ButtonStyle {
  final Color pressedColor;
  final Color normalColor;
  const ElevatedButtonStyle(
      {required this.normalColor, required this.pressedColor});
  @override
  WidgetStateColor get backgroundColor => WidgetStateColor.resolveWith(
        (states) {
          if (states.contains(WidgetState.pressed)) {
            return pressedColor;
          }
          return normalColor;
        },
      );

  @override
  WidgetStatePropertyAll<EdgeInsetsGeometry> get padding =>
      const WidgetStatePropertyAll(EdgeInsets.zero);

  @override
  WidgetStatePropertyAll<OutlinedBorder> get shape => WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );

  @override
  WidgetStateProperty<double> get elevation => WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.pressed)) {
            return 0;
          }
          return 0;
        },
      );
}
