import 'package:flutter/material.dart';

/// A custom sliver app bar.
class AppSliverAppBar extends StatelessWidget {
  /// Creates an [AppSliverAppBar].
  const AppSliverAppBar({super.key, this.title, this.actions});

  /// The primary widget displayed in the app bar.
  final Widget? title;

  /// A list of [Widget]s to display in a row after the [title] widget.
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: title,
      actions: actions,
    );
  }
}
