/// A collection of asset paths.
abstract final class Assets {
  /// The asset path of the exercise file.
  static const exercises = 'assets/exercises.json';

  /// The asset path of the thumbnail image for the exercise with [exerciseId].
  static String thumbnailFor(String exerciseId) =>
      'assets/thumbnails/$exerciseId.jpg';
}
