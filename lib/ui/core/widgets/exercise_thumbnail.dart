import 'package:flutter/material.dart';

import 'package:relift/ui/core/dimens.dart';

/// Displays a circular exercise thumbnail or a default icon.
class ExerciseThumbnail extends StatelessWidget {
  /// Creates an [ExerciseThumbnail].
  const ExerciseThumbnail({super.key, this.thumbnailUrl});

  /// An asset path for the exercise thumbnail.
  final String? thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl = this.thumbnailUrl;
    return thumbnailUrl != null
        ? CircleAvatar(
            foregroundImage: AssetImage(thumbnailUrl),
            radius: Dimens.thumbnailSize / 2,
          )
        : const CircleAvatar(child: Icon(Icons.fitness_center));
  }
}
