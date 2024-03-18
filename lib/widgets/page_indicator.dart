import 'package:flutter/material.dart';
import 'package:taskland/extensions/color_scheme_direct_access.dart';

/// Indicates which page the user is in.
class PageIndicator extends StatelessWidget {
  /// Total of pages that exist in screen.
  final int totalPages;

  /// The current page index that user is in.
  final int currentIndex;

  PageIndicator({
    super.key,
    required this.totalPages,
    required this.currentIndex,
  }) {
    // Check if total page count is valid
    assert(totalPages > 0);

    // Check if current index count is in valid range
    assert(currentIndex >= 0);

    // Check if current index is not out of range
    assert(currentIndex < totalPages);
  }

  @override
  Widget build(BuildContext context) {
    // Initialize variables
    final List<Widget> dots = [];
    Color dotColor = Colors.white;

    // Generate dot widgets according to parameters
    for (int i = 0; i < totalPages; i++) {
      // If we're generating dot at the current index,
      // make it with primary color
      if (i == currentIndex) {
        dotColor = Theme.of(context).primaryColor;
      } else {
        dotColor = context.colorScheme.primaryContainer;
      }

      // Add the new dot to the list
      dots.add(Container(
        width: 6,
        height: 6,
        decoration: ShapeDecoration(
          color: dotColor,
          shape: const OvalBorder(),
        ),
      ));

      // If we are not in the last indicator, add space between dots
      if (i != totalPages - 1) dots.add(const SizedBox(width: 6));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: dots,
    );
  }
}
