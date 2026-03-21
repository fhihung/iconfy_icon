import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'iconfy_icon_data.dart';

/// A widget that renders a flat SVG icon from [IconfyIconData].
///
/// Uses [SvgPicture.string] to render inline SVG content, enabling
/// tree-shaking of unused icons.
///
/// ```dart
/// IconfyIconWidget(
///   IconfyIcons.essential.home.bold.regular,
///   size: 24,
///   color: Colors.blue,
/// )
/// ```
class IconfyIconWidget extends StatelessWidget {
  /// The icon data to render.
  final IconfyIconData icon;

  /// Size of the icon (both width and height).
  /// Defaults to 24.
  final double size;

  /// Optional color to apply to the icon.
  /// Uses [BlendMode.srcIn] to colorize the SVG.
  final Color? color;

  /// How to inscribe the icon into the space allocated during layout.
  final BoxFit fit;

  /// Optional semantic label for accessibility.
  final String? semanticLabel;

  const IconfyIconWidget(
    this.icon, {
    super.key,
    this.size = 24,
    this.color,
    this.fit = BoxFit.contain,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      icon.svgContent,
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      fit: fit,
      semanticsLabel: semanticLabel ?? icon.name,
    );
  }
}
