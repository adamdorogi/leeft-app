import 'package:flutter/material.dart';

/// A chip for displaying a bottom sheet.
class BottomSheetFilterChip extends StatelessWidget {
  /// Creates a [BottomSheetFilterChip].
  const BottomSheetFilterChip({
    required this.label,
    required this.selectedCount,
    required this.onClear,
    required this.builder,
    super.key,
  });

  /// The chip label text.
  final String label;

  /// The number of selected items.
  final int selectedCount;

  /// Callback to clear the selection.
  final void Function() onClear;

  /// Builds the bottom sheet content.
  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      onDeleted: selectedCount != 0 ? onClear : null,
      label: Text(selectedCount != 0 ? '$label ($selectedCount)' : label),
      selected: selectedCount != 0,
      onSelected: (_) async => showModalBottomSheet(
        context: context,
        useSafeArea: true,
        showDragHandle: true,
        builder: builder,
      ),
    );
  }
}
