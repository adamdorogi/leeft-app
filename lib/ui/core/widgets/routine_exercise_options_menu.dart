import 'package:flutter/material.dart';

import 'package:relift/l10n/app_localizations.dart';

/// Menu for routine exercises.
class RoutineExerciseOptionsMenu extends StatelessWidget {
  /// Creates a [RoutineExerciseOptionsMenu].
  const RoutineExerciseOptionsMenu({
    required this.onReplace,
    required this.onRemove,
    super.key,
  });

  /// Called when replace is selected.
  final VoidCallback onReplace;

  /// Called when remove is selected.
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (_, controller, _) => IconButton(
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
        icon: const Icon(Icons.more_horiz),
      ),
      menuChildren: [
        // Replace.
        MenuItemButton(
          onPressed: onReplace,
          leadingIcon: const Icon(Icons.swap_horiz),
          child: Text(AppLocalizations.of(context).replace),
        ),
        // Remove.
        MenuItemButton(
          onPressed: onRemove,
          leadingIcon: const Icon(Icons.delete),
          child: Text(AppLocalizations.of(context).remove),
        ),
      ],
    );
  }
}
