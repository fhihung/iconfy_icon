/// Style variants for flat SVG icons.
enum IconfyStyle {
  bold,
  bulk,
  light,
  outline,
  twoTone,
  broken,
}

/// Type variants for flat SVG icons.
enum IconfyType {
  regular,
  sharp,
  curved,
}

/// Data class representing a flat SVG icon.
///
/// The [svgContent] field contains the full SVG markup as an inline string,
/// enabling Dart's tree-shaking to eliminate unused icons from the final bundle.
class IconfyIconData {
  /// Display name of the icon.
  final String name;

  /// Inline SVG content (tree-shakeable).
  final String svgContent;

  /// Category the icon belongs to (e.g., 'Essential', 'Arrow').
  final String category;

  /// Visual style of the icon.
  final IconfyStyle style;

  /// Type variant of the icon.
  final IconfyType type;

  const IconfyIconData({
    required this.name,
    required this.svgContent,
    required this.category,
    required this.style,
    required this.type,
  });

  @override
  String toString() => 'IconfyIconData($name, $category, $style, $type)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IconfyIconData &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          category == other.category &&
          style == other.style &&
          type == other.type;

  @override
  int get hashCode => Object.hash(name, category, style, type);
}
