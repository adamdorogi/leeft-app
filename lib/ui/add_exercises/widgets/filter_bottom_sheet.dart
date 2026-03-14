import 'package:flutter/material.dart';

/// A bottom sheet for displaying search filters.
class FilterBottomSheet extends StatelessWidget {
  /// Creates a [FilterBottomSheet].
  const FilterBottomSheet({
    required this.listenable,
    required this.title,
    required this.items,
    required this.labelBuilder,
    required this.isSelected,
    required this.onSelected,
    super.key,
  });

  /// A notifier that triggers filter UI rebuilds.
  final Listenable listenable;

  /// The header widget shown at the top of the sheet.
  final Widget title;

  /// The set of filter item identifiers to display.
  final Set<String> items;

  /// Builds the label widget for a filter item.
  final Widget Function(String) labelBuilder;

  /// Returns whether a filter item is currently selected.
  final bool Function(String) isSelected;

  /// Called when a filter item is selected or deselected.
  final void Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        PinnedHeaderSliver(
          child: ColoredBox(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            child: title,
          ),
        ),
        ListenableBuilder(
          listenable: listenable,
          builder: (_, _) => SliverToBoxAdapter(
            child: Wrap(
              children: items
                  .map(
                    (item) => FilterChip(
                      label: labelBuilder(item),
                      selected: isSelected(item),
                      onSelected: (_) => onSelected(item),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
