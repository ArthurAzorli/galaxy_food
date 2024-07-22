import 'dart:ui';

import 'package:flutter/material.dart';

class GalaxyButton extends ButtonStyleButton{

  final Widget? icon;

  GalaxyButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus = true,
    super.clipBehavior,
    super.statesController,
    super.iconAlignment,
    this.icon,
    required Widget child
  }) : super(
    child: icon == null
      ? child
      : _GalaxyButtonWithIcon(
      label: child,
      icon: icon,
      buttonStyle: style,
      iconAlignment: iconAlignment
    )
  );


  @override
  ButtonStyle defaultStyleOf(BuildContext context) => _GalaxyButtonDefaultStyle(context, icon != null);

  @override
  ButtonStyle? themeStyleOf(BuildContext context) => FilledButtonTheme.of(context).style;

}

class _GalaxyButtonWithIcon extends StatelessWidget {
  const _GalaxyButtonWithIcon({
    required this.label,
    required this.icon,
    required this.buttonStyle,
    required this.iconAlignment,
  });

  final Widget label;
  final Widget icon;
  final ButtonStyle? buttonStyle;
  final IconAlignment iconAlignment;

  @override
  Widget build(BuildContext context) {
    final double defaultFontSize = buttonStyle?.textStyle?.resolve(const <WidgetState>{})?.fontSize ?? 14.0;
    final double scale = clampDouble(MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0, 1.0, 2.0) - 1.0;

    final double gap = lerpDouble(8, 4, scale)!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: iconAlignment == IconAlignment.start
          ? <Widget>[icon, SizedBox(width: gap), Flexible(child: label)]
          : <Widget>[Flexible(child: label), SizedBox(width: gap), icon],
    );
  }
}

class _GalaxyButtonDefaultStyle extends ButtonStyle {

  final BuildContext context;
  final bool hasIcon;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  _GalaxyButtonDefaultStyle(this.context, this.hasIcon) : super(
    animationDuration: kThemeChangeDuration,
    enableFeedback: true,
    alignment: Alignment.center,
  );


  @override
  WidgetStateProperty<TextStyle?> get textStyle =>
      WidgetStatePropertyAll<TextStyle?>(Theme.of(context).textTheme.labelLarge);

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)){
          return _colors.primary;
        }
        if (states.contains(WidgetState.disabled)) {
          return _colors.onSurface.withOpacity(0.12);
        }
        return Colors.transparent;
      });

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        return _colors.secondary;
      });

  @override
  WidgetStateProperty<Color?>? get overlayColor =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return _colors.primary;
        }
        if (states.contains(WidgetState.hovered)) {
          return _colors.primary.withOpacity(0.08);
        }
        if (states.contains(WidgetState.focused)) {
          return _colors.primary.withOpacity(0.1);
        }
        return null;
      });

  @override
  WidgetStateProperty<Color>? get shadowColor =>
      WidgetStatePropertyAll<Color>(_colors.shadow);

  @override
  WidgetStateProperty<Color>? get surfaceTintColor =>
      const WidgetStatePropertyAll<Color>(Colors.transparent);

  @override
  WidgetStateProperty<double>? get elevation =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return 1.0;
        }
        return 0.0;
      });

  @override
  WidgetStateProperty<EdgeInsetsGeometry>? get padding =>
      WidgetStatePropertyAll<EdgeInsetsGeometry>(_scaledPadding(context, hasIcon));

  @override
  WidgetStateProperty<Size>? get minimumSize =>
      const WidgetStatePropertyAll<Size>(Size(64.0, 40.0));

  // No default fixedSize

  @override
  WidgetStateProperty<Size>? get maximumSize =>
      const WidgetStatePropertyAll<Size>(Size.infinite);

  @override
  WidgetStateProperty<BorderSide?>? get side =>
    WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected) || states.contains(WidgetState.pressed)){
        return null;
      }
      return BorderSide(
        color: _colors.secondary,
        width: 1.5,
      );
    });


  @override
  WidgetStateProperty<OutlinedBorder>? get shape =>
      WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ));

  @override
  WidgetStateProperty<MouseCursor?>? get mouseCursor =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      });

  @override
  VisualDensity? get visualDensity => Theme.of(context).visualDensity;

  @override
  MaterialTapTargetSize? get tapTargetSize => Theme.of(context).materialTapTargetSize;

  @override
  InteractiveInkFeatureFactory? get splashFactory => Theme.of(context).splashFactory;
}

EdgeInsetsGeometry _scaledPadding(BuildContext context, [bool hasIcon = false]) {

  final ThemeData theme = Theme.of(context);
  final double defaultFontSize = theme.textTheme.labelLarge?.fontSize ?? 14.0;
  final double effectiveTextScale = MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0;
  final double padding1x = theme.useMaterial3 ? 24.0 : 16.0;

  if (hasIcon) {
    return ButtonStyleButton.scaledPadding(
       EdgeInsets.only(left: padding1x * 2 / 3, right:  padding1x, top: padding1x * 2 / 3, bottom: padding1x * 2 / 3),
       EdgeInsets.only(left: padding1x / 3, right:  padding1x / 2,  top: padding1x / 3, bottom: padding1x / 3),
       EdgeInsets.only(left: padding1x / 3 / 2, right:  padding1x / 2 / 2,  top: padding1x / 3 / 2, bottom: padding1x / 3 / 2),
      effectiveTextScale
    );
  }

  return ButtonStyleButton.scaledPadding(
    EdgeInsets.symmetric(horizontal: padding1x, vertical: padding1x * 2 / 3),
    EdgeInsets.symmetric(horizontal: padding1x / 2, vertical: padding1x / 3),
    EdgeInsets.symmetric(horizontal: padding1x / 2 / 2, vertical: padding1x / 3 / 2),
    effectiveTextScale,
  );
}