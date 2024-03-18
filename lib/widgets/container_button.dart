import 'package:flutter/material.dart';
import 'package:taskland/consts/colors.dart';
import 'package:taskland/extensions/color_scheme_direct_access.dart';

class ContainerButton extends StatelessWidget {
  final void Function() onPressed;
  final Icon icon;
  final String content;

  final bool secondaryContainer;

  const ContainerButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.content,
    this.secondaryContainer = false,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = secondaryContainer
        ? m3PrimaryFixedDim
        : context.colorScheme.primaryContainer;

    final foregroundColor = secondaryContainer
        ? context.colorScheme.onSecondaryContainer
        : context.colorScheme.onPrimaryContainer;

    return Material(
      borderRadius: BorderRadius.circular(16),
      color: backgroundColor,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        splashColor: context.colorScheme.primary.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon.icon,
                color: foregroundColor,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  content,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: foregroundColor),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: foregroundColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
