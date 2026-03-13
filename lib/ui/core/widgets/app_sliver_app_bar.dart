import 'package:flutter/material.dart';

/// A custom sliver app bar.
class AppSliverAppBar extends StatelessWidget {
  /// Creates an [AppSliverAppBar].
  const AppSliverAppBar({super.key, this.title, this.bottom, this.actions});

  /// The primary widget displayed in the app bar.
  final Widget? title;

  /// The widget across the bottom of the app bar.
  final PreferredSizeWidget? bottom;

  /// A list of [Widget]s to display in a row after the [title] widget.
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: title,
      bottom: bottom,
      actions: actions,
    );
  }
}
