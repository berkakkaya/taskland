import 'package:flutter/material.dart';
import 'package:taskland/extensions/color_scheme_direct_access.dart';
import 'package:taskland/services/version_fetching.dart';

class VersionCard extends StatelessWidget {
  const VersionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Taskland",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: context.colorScheme.onPrimaryContainer,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "v${VersionFetchingService.version}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onPrimaryContainer,
                ),
          ),
          const SizedBox(height: 8),
          const Chip(
            padding: EdgeInsets.zero,
            avatar: Icon(Icons.auto_awesome),
            label: Text("Ön Sürüm"),
          ),
        ],
      ),
    );
  }
}
