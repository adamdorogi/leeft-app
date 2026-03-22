import 'package:flutter/material.dart';

import 'package:relift/l10n/app_localizations.dart';

/// Menu for routine actions.
class RoutineOptionsMenu extends StatelessWidget {
  /// Creates a [RoutineOptionsMenu].
  const RoutineOptionsMenu({
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  /// Called when edit is selected.
  final void Function() onEdit;

  /// Called when delete is selected.
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
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
          child: Text(AppLocalizations.of(context).edit),
        ),
        // Delete.
        MenuItemButton(
          onPressed: onDelete,
          leadingIcon: const Icon(Icons.delete),
          child: Text(AppLocalizations.of(context).delete),
        ),
      ],
    );
  }
}
