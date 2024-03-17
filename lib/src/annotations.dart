import 'package:build/build.dart';

/// {@template generate_field_keys}
/// Mark a class for field key generation, allowing for type-safe access to
/// field names.
///
/// The generator will generate a class named `$<ClassName>FieldKeys` that
/// contains static constants for each field.
///
/// For example, given the following class:
/// ```dart
/// @GenerateFieldKeys()
/// class Example {
///  final String name;
///  final int age;
///  final bool isAwesome;
/// }
/// ```
///
/// The generated class would look like:
/// ```dart
/// class $ExampleFieldKeys {
///  static const name = 'name';
///  static const age = 'age';
///  static const isAwesome = 'isAwesome';
/// }
/// ```
///
/// If [include] is not empty, only fields in [include] will be included in the
/// generated class. If [exclude] is not empty, only fields not in [exclude] will
/// be included in the generated class.
///
/// If both [include] and [exclude] are empty, all fields will be included in the
/// generated class.
///
/// Only one of [include] or [exclude] can be non-empty.
///
/// The part directive `part '<file_name>.g.dart';` must be included in the file
/// where the class is defined.
/// {@endtemplate}
class GenerateFieldKeys {
  /// {@macro generate_field_keys}
  const GenerateFieldKeys({
    this.include = const [],
    this.exclude = const [],
  });

  /// The fields to include in the generated class.
  final List<String> include;

  /// The fields to exclude from the generated class..
  final List<String> exclude;
}
