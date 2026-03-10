import 'package:flutter/material.dart';

import 'package:relift/l10n/app_localizations.dart';

/// Menu for routine actions.
class RoutineOptionsMenu extends StatelessWidget {
  /// Creates a [RoutineOptionsMenu].
  const RoutineOptionsMenu({
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

  /// Called when delete is selected.
  final VoidCallback onDelete;

  /// Called when edit is selected.
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return MenuAnchor(
      builder: (_, controller, _) => IconButton(
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
        icon: const Icon(Icons.more_horiz),
      ),
      menuChildren: [
        // Edit.
        MenuItemButton(
          onPressed: onEdit,
          leadingIcon: const Icon(Icons.edit),
          child: Text(localizations.edit),
        ),
        // Delete.
        MenuItemButton(
          onPressed: onDelete,
          leadingIcon: const Icon(Icons.delete),
          child: Text(localizations.delete),
        ),
      ],
    );
  }
}
