import 'package:flutter/material.dart';

extension ColorSchemeDirectAccess on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
