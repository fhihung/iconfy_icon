// ignore_for_file: avoid_print
/// Code generation script for iconfy_icon package.
///
/// Reads SVG files from `assets/flat/` and `_metadata.json`,
/// then generates Dart const classes with inline SVG content.
///
/// Usage: dart run tool/generate.dart
import 'dart:io';

/// Convert a raw icon/category name to a valid Dart identifier in camelCase.
String toCamelCase(String input) {
  // Clean up: trim, replace special chars with spaces
  var cleaned = input.trim().replaceAll(RegExp(r'[^a-zA-Z0-9\s_]'), ' ');
  // Split by spaces/underscores
  final parts = cleaned.split(RegExp(r'[\s_]+'))
    ..removeWhere((s) => s.isEmpty);
  if (parts.isEmpty) return 'unnamed';

  final result = StringBuffer();
  for (var i = 0; i < parts.length; i++) {
    final word = parts[i].toLowerCase();
    if (i == 0) {
      result.write(word);
    } else {
      result.write(word[0].toUpperCase() + word.substring(1));
    }
  }

  var identifier = result.toString();
  // Ensure it starts with a letter
  if (identifier.isNotEmpty && RegExp(r'^[0-9]').hasMatch(identifier)) {
    identifier = 'i$identifier';
  }
  // Reserved words
  const reserved = {'class', 'new', 'switch', 'default', 'return', 'if', 'else', 'for', 'do', 'while', 'break', 'continue', 'try', 'catch', 'finally', 'throw', 'this', 'super', 'is', 'in', 'as', 'true', 'false', 'null', 'var', 'final', 'const', 'void', 'int', 'double', 'bool', 'String', 'List', 'Map', 'Set', 'enum', 'abstract', 'extends', 'implements', 'with', 'import', 'export', 'library', 'part', 'typedef', 'operator', 'get', 'set', 'static', 'factory', 'external', 'assert', 'async', 'await', 'yield'};
  if (reserved.contains(identifier)) {
    identifier = '${identifier}Icon';
  }
  return identifier;
}

String toPascalCase(String input) {
  final camel = toCamelCase(input);
  if (camel.isEmpty) return 'Unnamed';
  return camel[0].toUpperCase() + camel.substring(1);
}

/// Capitalize the first letter of an already-camelCase string.
/// Unlike toPascalCase, this does NOT re-lowercase the input.
String capitalize(String input) {
  if (input.isEmpty) return 'Unnamed';
  return input[0].toUpperCase() + input.substring(1);
}

/// Map folder name to Dart enum value name.
String styleToEnumValue(String style) {
  switch (style.toLowerCase()) {
    case 'bold': return 'bold';
    case 'bulk': return 'bulk';
    case 'light': return 'light';
    case 'outline': return 'outline';
    case 'twotone': return 'twoTone';
    case 'broken': return 'broken';
    default: return style.toLowerCase();
  }
}

String typeToEnumValue(String type) {
  switch (type.toLowerCase()) {
    case 'regular': return 'regular';
    case 'sharp': return 'sharp';
    case 'curved': return 'curved';
    default: return type.toLowerCase();
  }
}

/// Escape a string for embedding as a Dart single-quoted raw string.
String escapeSvgForDart(String svg) {
  // Use single-quoted string with escaping
  return svg
      .replaceAll(r'\', r'\\')
      .replaceAll("'", r"\'")
      .replaceAll(r'$', r'\$')
      .replaceAll('\r\n', ' ')
      .replaceAll('\n', ' ')
      .replaceAll('\r', ' ');
}

/// Represents a discovered icon with all its style/type variants.
class IconEntry {
  final String name;
  final String dartName; // camelCase
  final String category;
  /// style -> type -> svgContent
  final Map<String, Map<String, String>> variants = {};

  IconEntry({required this.name, required this.dartName, required this.category});
}

void main() async {
  final projectDir = Directory.current.path;
  final assetsDir = Directory('$projectDir/assets/flat');
  final outputDir = Directory('$projectDir/lib/src/generated');

  if (!assetsDir.existsSync()) {
    print('❌ assets/flat/ not found. Run from the iconfy_icon package root.');
    exit(1);
  }

  // Ensure output dir exists
  outputDir.createSync(recursive: true);

  print('🔍 Scanning categories...');

  // Discover categories (top-level dirs in assets/flat/)
  final categoryDirs = assetsDir.listSync()
      .whereType<Directory>()
      .where((d) => !d.path.endsWith('_progress.json'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  final categoryNames = <String>[]; // camelCase dart names for entry point file
  final categoryFolders = <String>[]; // raw folder names for consistent class names

  for (final categoryDir in categoryDirs) {
    final categoryFolder = categoryDir.path.split('/').last;
    if (categoryFolder.startsWith('_')) continue; // skip _metadata.json etc.

    final categoryDartName = toCamelCase(categoryFolder);
    final categoryClassName = '_${toPascalCase(categoryFolder)}Icons';
    categoryNames.add(categoryDartName);
    categoryFolders.add(categoryFolder);

    print('📁 Processing category: $categoryFolder');

    // Discover all icons in this category
    // Structure: Category/Style/Type/IconName.svg
    // We keep ALL icons, including those with different numeric IDs.
    // Duplicates are renamed: Headphone, Headphone_1, Headphone_2, etc.

    // First pass: collect all unique filenames (with IDs) grouped by base name
    // Key: original filename (with ID stripped) -> List of original filenames
    final baseNameToOriginals = <String, List<String>>{};
    // Also track which original filenames appear in which style/type with their SVG content
    // Key: original filename -> style -> type -> svgContent
    final fileVariants = <String, Map<String, Map<String, String>>>{};

    final styleDirs = categoryDir.listSync().whereType<Directory>().toList();

    for (final styleDir in styleDirs) {
      final styleName = styleDir.path.split('/').last;
      final styleEnum = styleToEnumValue(styleName);

      final typeDirs = styleDir.listSync().whereType<Directory>().toList();

      for (final typeDir in typeDirs) {
        final typeName = typeDir.path.split('/').last;
        final typeEnum = typeToEnumValue(typeName);

        final svgFiles = typeDir.listSync()
            .whereType<File>()
            .where((f) => f.path.endsWith('.svg'))
            .toList();

        for (final svgFile in svgFiles) {
          var fileName = svgFile.path.split('/').last;
          fileName = fileName.replaceAll('.svg', '');

          // Compute base name (strip trailing _12345 ID suffix)
          final baseName = fileName.replaceAll(RegExp(r'_\d+$'), '');

          // Track this original filename under its base name
          baseNameToOriginals.putIfAbsent(baseName, () => []);
          if (!baseNameToOriginals[baseName]!.contains(fileName)) {
            baseNameToOriginals[baseName]!.add(fileName);
          }

          // Read SVG content
          final svgContent = svgFile.readAsStringSync();
          fileVariants.putIfAbsent(fileName, () => {});
          fileVariants[fileName]!.putIfAbsent(styleEnum, () => {});
          fileVariants[fileName]![styleEnum]![typeEnum] = svgContent;
        }
      }
    }

    // Second pass: assign final names to each icon
    // For base names with only 1 original: use the base name directly
    // For base names with multiple originals: first gets base name, rest get base_1, base_2, ...
    // Also handles dartName collisions from different base names (e.g., Song_ and Song both -> song)
    final icons = <String, IconEntry>{}; // dartName -> IconEntry

    for (final entry in baseNameToOriginals.entries) {
      final baseName = entry.key;
      final originals = entry.value..sort(); // Sort for deterministic ordering

      for (var i = 0; i < originals.length; i++) {
        final originalFileName = originals[i];
        String finalName;
        if (originals.length == 1) {
          finalName = baseName;
        } else {
          finalName = i == 0 ? baseName : '${baseName}_$i';
        }

        var dartName = toCamelCase(finalName);
        final displayName = finalName.replaceAll('_', ' ').trim();

        // Handle dartName collision (different base names producing same camelCase)
        if (icons.containsKey(dartName)) {
          var suffix = 1;
          while (icons.containsKey('${dartName}$suffix')) {
            suffix++;
          }
          dartName = '${dartName}$suffix';
        }

        final iconEntry = IconEntry(
          name: displayName,
          dartName: dartName,
          category: categoryFolder,
        );

        // Copy variants from fileVariants
        if (fileVariants.containsKey(originalFileName)) {
          for (final styleEntry in fileVariants[originalFileName]!.entries) {
            iconEntry.variants.putIfAbsent(styleEntry.key, () => {});
            for (final typeEntry in styleEntry.value.entries) {
              iconEntry.variants[styleEntry.key]![typeEntry.key] = typeEntry.value;
            }
          }
        }

        icons[dartName] = iconEntry;
      }
    }

    if (icons.isEmpty) {
      print('  ⚠️  No icons found, skipping...');
      continue;
    }

    // Generate Dart file for this category
    final buffer = StringBuffer();
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln('// ignore_for_file: constant_identifier_names, non_constant_identifier_names, unused_element');
    buffer.writeln('// Generated from assets/flat/$categoryFolder/');
    buffer.writeln();
    buffer.writeln("part of 'iconfy_icons.dart';");
    buffer.writeln();

    // Category class
    buffer.writeln('/// Icons in the "$categoryFolder" category.');
    buffer.writeln('class $categoryClassName {');
    buffer.writeln('  const $categoryClassName();');
    buffer.writeln();

    for (final icon in icons.values) {
      final iconClassName = '_${toPascalCase(categoryFolder)}${capitalize(icon.dartName)}Icon';
      buffer.writeln('  /// ${icon.name}');
      buffer.writeln('  $iconClassName get ${icon.dartName} => const $iconClassName();');
    }
    buffer.writeln('}');
    buffer.writeln();

    // Icon classes (icon -> style -> type)
    for (final icon in icons.values) {
      final iconClassName = '_${toPascalCase(categoryFolder)}${capitalize(icon.dartName)}Icon';

      buffer.writeln('/// ${icon.name} icon with style variants.');
      buffer.writeln('class $iconClassName {');
      buffer.writeln('  const $iconClassName();');
      buffer.writeln();

      // Generate style getters
      for (final style in ['bold', 'bulk', 'light', 'outline', 'twoTone', 'broken']) {
        if (icon.variants.containsKey(style)) {
          final styleClassName = '_${toPascalCase(categoryFolder)}${capitalize(icon.dartName)}${toPascalCase(style)}';
          buffer.writeln('  /// $style style');
          buffer.writeln('  $styleClassName get $style => const $styleClassName();');
        }
      }
      buffer.writeln('}');
      buffer.writeln();

      // Style classes (type getters returning IconfyIconData)
      for (final styleEntry in icon.variants.entries) {
        final style = styleEntry.key;
        final types = styleEntry.value;
        final styleClassName = '_${toPascalCase(categoryFolder)}${capitalize(icon.dartName)}${toPascalCase(style)}';

        buffer.writeln('/// ${icon.name} — $style style variants.');
        buffer.writeln('class $styleClassName {');
        buffer.writeln('  const $styleClassName();');
        buffer.writeln();

        for (final typeEntry in types.entries) {
          final type = typeEntry.key;
          final svgContent = escapeSvgForDart(typeEntry.value);

          buffer.writeln('  /// ${icon.name} — $style / $type');
          buffer.writeln('  IconfyIconData get $type => const IconfyIconData(');
          buffer.writeln("    name: '${icon.name.replaceAll("'", "\\'")}',");
          buffer.writeln("    svgContent: '$svgContent',");
          buffer.writeln("    category: '${icon.category.replaceAll("'", "\\'")}',");
          buffer.writeln('    style: IconfyStyle.$style,');
          buffer.writeln('    type: IconfyType.$type,');
          buffer.writeln('  );');
          buffer.writeln();
        }
        buffer.writeln('}');
        buffer.writeln();
      }
    }

    // Write file
    final outputFile = File('${outputDir.path}/$categoryDartName.g.dart');
    outputFile.writeAsStringSync(buffer.toString());
    print('  ✅ Generated ${outputFile.path.split('/').last} (${icons.length} icons)');
  }

  // Generate entry point file: iconfy_icons.dart
  print('📝 Generating entry point...');
  final entryBuffer = StringBuffer();
  entryBuffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  entryBuffer.writeln('// ignore_for_file: constant_identifier_names, non_constant_identifier_names');
  entryBuffer.writeln();
  entryBuffer.writeln("import '../iconfy_icon_data.dart';");
  entryBuffer.writeln();

  for (final name in categoryNames) {
    entryBuffer.writeln("part '$name.g.dart';");
  }
  entryBuffer.writeln();

  entryBuffer.writeln('/// Entry point for all Iconly Pro flat SVG icons.');
  entryBuffer.writeln('///');
  entryBuffer.writeln('/// Usage: `IconfyIcons.essential.home.bold.regular`');
  entryBuffer.writeln('class IconfyIcons {');
  entryBuffer.writeln('  const IconfyIcons._();');
  entryBuffer.writeln();

  for (var i = 0; i < categoryNames.length; i++) {
    final name = categoryNames[i];
    final folder = categoryFolders[i];
    final className = '_${toPascalCase(folder)}Icons';
    entryBuffer.writeln('  static const $name = $className();');
  }

  entryBuffer.writeln('}');

  final entryFile = File('${outputDir.path}/iconfy_icons.dart');
  entryFile.writeAsStringSync(entryBuffer.toString());

  print('');
  print('🎉 Done! Generated ${categoryNames.length} category files.');
  print('📦 Total icons ready for tree-shaking.');
}
